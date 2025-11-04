const express = require("express");
const mysql = require("mysql2");
const bcrypt = require("bcryptjs");
const cors = require("cors");
const bodyParser = require("body-parser");
const moment = require("moment");
require("dotenv").config();

const app = express();
const port = process.env.PORT || 5000;

app.use(cors());
app.use(bodyParser.json());

// ✅ MySQL Connection
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

db.connect((err) => {
  if (err) console.error("❌ DB connection failed:", err);
  else console.log("✅ Connected to MySQL database");
});

// ==========================
//  TEST ROUTE
// ==========================
app.get("/", (req, res) => res.send("Backend is running!"));

// ==========================
//  TIPS ROUTES
// ==========================
app.get("/api/tips", (req, res) => {
  db.query("SELECT * FROM tips ORDER BY created_at DESC", (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

app.post("/api/tips", (req, res) => {
  const { title, description } = req.body;
  if (!title || !description)
    return res.status(400).json({ error: "Title and description required" });

  db.query(
    "INSERT INTO tips (title, description) VALUES (?, ?)",
    [title, description],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ message: "Tip added successfully", tipId: result.insertId });
    }
  );
});

// ==========================
//  USER AUTH ROUTES
// ==========================
app.post("/api/register", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    if (!name || !email || !password)
      return res.status(400).json({ message: "All fields required" });

    const [existing] = await db
      .promise()
      .query("SELECT * FROM users WHERE email=?", [email]);
    if (existing.length > 0)
      return res.status(400).json({ message: "Email already exists" });

    const hashed = await bcrypt.hash(password, 10);
    await db
      .promise()
      .query("INSERT INTO users (name, email, password) VALUES (?, ?, ?)", [
        name,
        email,
        hashed,
      ]);
    res.status(201).json({ message: "User registered successfully" });
  } catch (err) {
    console.error("Register error:", err);
    res.status(500).json({ message: "Server error" });
  }
});

app.post("/api/login", (req, res) => {
  const { email, password } = req.body;
  db.query("SELECT * FROM users WHERE email=?", [email], async (err, results) => {
    if (err) return res.status(500).json({ message: "DB error" });
    if (results.length === 0)
      return res.status(401).json({ message: "Invalid email or password" });

    const user = results[0];
    const match = await bcrypt.compare(password, user.password);
    if (!match)
      return res.status(401).json({ message: "Invalid email or password" });

    const token = Buffer.from(`${user.email}:${Date.now()}`).toString("base64");
    res.json({ message: "Login successful", token, name: user.name, id: user.id });
  });
});

// ==========================
//  ADMIN LOGIN
// ==========================
const adminLoginHandler = async (req, res) => {
  try {
    const { username, password } = req.body;
    if (!username || !password)
      return res.status(400).json({ message: "All fields required" });

    const [admins] = await db
      .promise()
      .query("SELECT * FROM admins WHERE username=?", [username]);
    if (admins.length === 0)
      return res.status(401).json({ message: "Invalid credentials" });

    const admin = admins[0];
    const match = await bcrypt.compare(password, admin.password);
    if (!match)
      return res.status(401).json({ message: "Invalid credentials" });

    const token = Buffer.from(`${admin.username}:${Date.now()}`).toString("base64");
    res.json({ message: "Admin login successful", token, name: admin.username });
  } catch (err) {
    console.error("Admin login error:", err);
    res.status(500).json({ message: "Server error" });
  }
};
app.post("/api/admin/login", adminLoginHandler);
app.post("/admin/login", adminLoginHandler);

// ==========================
//  SLOT GENERATION
// ==========================
const SERVICE_CONFIG = {
  consultation: { duration: 60, price: 1500, endHour: 18 },
  consultation_assessment: { duration: 120, price: 4000, endHour: 19 },
  parenting: { duration: 60, price: 5000, endHour: 18 },
};

app.post("/api/admin/slots/populate", async (req, res) => {
  try {
    const today = moment().startOf("day");
    const insertPromises = [];

    for (let i = 0; i < 15; i++) {
      const date = today.clone().add(i, "days").format("YYYY-MM-DD");

      for (const [type, config] of Object.entries(SERVICE_CONFIG)) {
        let start = moment("09:00", "HH:mm");
        const end = moment(`${config.endHour}:00`, "HH:mm");

        while (start.clone().add(config.duration, "minutes").isSameOrBefore(end)) {
          const startTime = start.format("HH:mm:ss");
          const endTime = start.clone().add(config.duration, "minutes").format("HH:mm:ss");

          insertPromises.push(
            db
              .promise()
              .query(
                `INSERT IGNORE INTO slots 
                 (doctor_id, slot_date, start_time, end_time, service_type, price) 
                 VALUES (1, ?, ?, ?, ?, ?)`,
                [date, startTime, endTime, type, config.price]
              )
          );
          start.add(config.duration, "minutes");
        }
      }
    }
    await Promise.all(insertPromises);
    res.json({ message: "✅ Slots populated for next 15 days" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Slot generation failed" });
  }
});

// ==========================
//  PATIENT SLOT FETCH
// ==========================
app.get("/api/patient/slots", (req, res) => {
  const { date, service_type } = req.query;
  if (!date || !service_type)
    return res.status(400).json({ message: "Date & service_type required" });

  const sql = `
    SELECT id, slot_date, start_time, end_time, service_type, is_booked, is_closed 
    FROM slots 
    WHERE slot_date = ? AND service_type = ? 
    ORDER BY start_time ASC
  `;

  db.query(sql, [date, service_type], (err, slots) => {
    if (err) return res.status(500).json({ message: err.message });

    // get all booked slots for overlap prevention
    const bookedSql = `
      SELECT start_time, end_time FROM slots 
      WHERE slot_date = ? AND is_booked = 1
    `;
    db.query(bookedSql, [date], (err, bookedSlots) => {
      if (err) return res.status(500).json({ message: err.message });

      const updated = slots.map((s) => {
        const overlap = bookedSlots.some(
          (b) => s.start_time < b.end_time && s.end_time > b.start_time
        );
        return { ...s, is_booked: s.is_booked || overlap || s.is_closed };
      });
      res.json(updated);
    });
  });
});

// ==========================
//  BOOK SLOT + PAYMENT
// ==========================
app.post("/api/book-slot", async (req, res) => {
  try {
    const { slot_id, user_id, service_type } = req.body;

    const [slot] = await db
      .promise()
      .query("SELECT * FROM slots WHERE id=? AND is_booked=0", [slot_id]);
    if (slot.length === 0)
      return res.status(400).json({ message: "Slot unavailable" });

    const s = slot[0];

    // Mark overlapping slots closed
    await db
      .promise()
      .query(
        `UPDATE slots SET is_closed=1 
         WHERE slot_date=? AND id!=? 
         AND ((start_time < ? AND end_time > ?) OR (start_time < ? AND end_time > ?))`,
        [s.slot_date, s.id, s.end_time, s.start_time, s.start_time, s.end_time]
      );

    await db.promise().query("UPDATE slots SET is_booked=1 WHERE id=?", [slot_id]);

    const [result] = await db
      .promise()
      .query(
        `INSERT INTO payments (user_id, service_type, slot_id, amount, payment_status)
         VALUES (?, ?, ?, ?, 'Pending')`,
        [user_id, service_type, slot_id, s.price]
      );

    res.json({
      message: "Slot booked successfully. Proceed to payment.",
      paymentId: result.insertId,
      amount: s.price,
      slot_time: `${s.start_time} - ${s.end_time}`,
    });
  } catch (err) {
    console.error("Booking error:", err);
    res.status(500).json({ message: "Booking failed" });
  }
});

// ==========================
//  CONFIRM PAYMENT
// ==========================
app.post("/api/confirm-payment", async (req, res) => {
  const { paymentId } = req.body;
  if (!paymentId) return res.status(400).json({ message: "Payment ID required" });

  try {
    await db
      .promise()
      .query("UPDATE payments SET payment_status='Completed' WHERE id=?", [
        paymentId,
      ]);
    res.json({ message: "✅ Payment confirmed" });
  } catch (err) {
    console.error("Payment confirm error:", err);
    res.status(500).json({ message: "Payment update failed" });
  }
});

// ==========================
//  SERVICES FETCH
// ==========================
app.get("/api/services", (req, res) => {
  db.query("SELECT service_type, name, description, price FROM services", (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// POST /api/payment/mock
app.post("/api/payment/mock", async (req, res) => {
  try {
    const { patientId, slotId, serviceType, amount } = req.body;

    // Insert into payments table
    await db.query(
      `INSERT INTO payments (patient_id, slot_id, service_type, amount, payment_status, payment_mode, payment_time)
       VALUES (?, ?, ?, ?, 'paid', 'UPI-QR', NOW())`,
      [patientId, slotId, serviceType, amount]
    );

    // Mark slot as booked
    await db.query(`UPDATE slots SET is_booked = 1 WHERE id = ?`, [slotId]);

    res.json({ success: true, message: "Payment recorded successfully" });
  } catch (err) {
    console.error("Mock payment error:", err);
    res.status(500).json({ success: false, message: "Payment record failed" });
  }
});
// ✅ Record Payment API
app.post("/api/payment", (req, res) => {
  const { userId, slotId, amount } = req.body;

  if (!userId || !slotId || !amount) {
    return res.status(400).json({ success: false, message: "Missing payment details" });
  }

  const createdAt = moment().format("YYYY-MM-DD HH:mm:ss");

  const insertPayment = `
    INSERT INTO payments (user_id, slot_id, amount, status, created_at)
    VALUES (?, ?, ?, 'Completed', ?)
  `;

  db.query(insertPayment, [userId, slotId, amount, createdAt], (err, result) => {
    if (err) {
      console.error("❌ Payment insert failed:", err);
      return res.status(500).json({ success: false, message: "Payment failed to record" });
    }

    // ✅ Get the date of that slot
    const getSlotDate = `SELECT slot_date FROM slots WHERE id = ?`;

    db.query(getSlotDate, [slotId], (dateErr, dateResult) => {
      if (dateErr || !dateResult.length) {
        console.error("⚠️ Failed to get slot date:", dateErr);
        return res.status(500).json({ success: false, message: "Slot date not found" });
      }

      const slotDate = dateResult[0].slot_date;

      // ✅ Mark only that specific date's slot as booked
      const updateSlot = `UPDATE slots SET is_booked = 1 WHERE id = ? AND slot_date = ?`;

      db.query(updateSlot, [slotId, slotDate], (updateErr) => {
        if (updateErr) {
          console.error("⚠️ Failed to update slot booking:", updateErr);
          return res.status(500).json({ success: false, message: "Payment saved but slot update failed" });
        }

        console.log("✅ Payment recorded and slot marked as booked");
        res.json({ success: true, message: "Payment recorded successfully" });
      });
    });
  });
});





// ==========================
//  SERVER START
// ==========================
app.listen(port, () =>
  console.log(`🚀 Server running at http://localhost:${port}`)
);
