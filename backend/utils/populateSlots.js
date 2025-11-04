// backend/utils/populateSlots.js
const dayjs = require("dayjs");

const populateSlots = async (db) => {
  const NUM_DAYS = 15; // Next 15 days
  const DOCTOR_ID = 1; // Default doctor
  const DEFAULT_PRICE = 500;
  const START_TIME = "18:00:00";
  const END_TIME = "21:00:00";

  const today = dayjs();

  for (let i = 0; i < NUM_DAYS; i++) {
    const date = today.add(i, "day").format("YYYY-MM-DD");

    const [existing] = await db.query(
      "SELECT * FROM slots WHERE doctor_id = ? AND DATE(start_time) = ?",
      [DOCTOR_ID, date]
    );

    if (existing.length === 0) {
      await db.query(
        "INSERT INTO slots (doctor_id, start_time, end_time, price, is_booked) VALUES (?, ?, ?, ?, 0)",
        [DOCTOR_ID, `${date} ${START_TIME}`, `${date} ${END_TIME}`, DEFAULT_PRICE]
      );
      console.log(`Inserted slot for ${date}`);
    }
  }
};

module.exports = populateSlots;
