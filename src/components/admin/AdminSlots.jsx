import React, { useState, useEffect } from "react";
import axios from "axios";
import dayjs from "dayjs";

const AdminSlots = () => {
  const [slots, setSlots] = useState([]);
  const [loading, setLoading] = useState(true);
  const token = localStorage.getItem("adminToken");

  useEffect(() => {
    if (!token) return;

    const fetchOrPopulate = async () => {
      try {
        // ✅ First, call populate API
        await axios.post(
          "http://localhost:5000/api/admin/slots/populate",
          {},
          { headers: { Authorization: token } }
        );
        console.log("Slots populate API called");

        // ✅ Then fetch slots
        const res = await axios.get("http://localhost:5000/api/admin/slots", {
          headers: { Authorization: token },
        });
        setSlots(res.data);
        setLoading(false);
      } catch (err) {
        console.error("Error fetching or populating slots:", err);
        setLoading(false);
      }
    };

    fetchOrPopulate();
  }, [token]);

  const handleChange = (index, field, value) => {
    const updated = [...slots];
    updated[index][field] = value;
    setSlots(updated);
  };

  const handleSave = async (slot) => {
    try {
      await axios.post(
        "http://localhost:5000/api/admin/slots/update",
        slot,
        { headers: { Authorization: token } }
      );
      alert("Slot updated successfully!");
    } catch (err) {
      console.error(err);
      alert("Failed to update slot");
    }
  };

  if (!token) return <p className="text-center mt-20 text-red-600">Please login as admin</p>;
  if (loading) return <p className="text-center mt-20">Loading...</p>;

  return (
    <div className="max-w-4xl mx-auto mt-10 p-6 bg-white rounded-2xl shadow-md">
      <h2 className="text-2xl font-bold text-pink-600 mb-6 text-center">Manage Slots</h2>

      <table className="w-full border-collapse text-center">
        <thead>
          <tr className="bg-pink-100">
          <th className="border p-2">Service Type</th>
            <th className="border p-2">Date</th>
            <th className="border p-2">Day</th>
            <th className="border p-2">Start Time</th>
            <th className="border p-2">End Time</th>
            <th className="border p-2">Closed</th>
            <th className="border p-2">Action</th>
          </tr>
        </thead>
        <tbody>
          {slots.map((slot, index) => (
            <tr key={slot.slot_date} className={slot.day === "Saturday" || slot.day === "Sunday" ? "bg-yellow-100" : ""}>
              <td className="border p-2">{slot.service_type}</td>
              <td className="border p-2">{slot.slot_date}</td>
              <td className="border p-2">{dayjs(slot.slot_date).format("dddd")}</td>
              <td className="border p-2">
                <input
                  type="time"
                  value={slot.start_time}
                  disabled={slot.is_closed}
                  onChange={(e) => handleChange(index, "start_time", e.target.value)}
                  className="border p-1 rounded"
                />
              </td>
              <td className="border p-2">
                <input
                  type="time"
                  value={slot.end_time}
                  disabled={slot.is_closed}
                  onChange={(e) => handleChange(index, "end_time", e.target.value)}
                  className="border p-1 rounded"
                />
              </td>
              <td className="border p-2">
                <input
                  type="checkbox"
                  checked={slot.is_closed}
                  onChange={(e) => handleChange(index, "is_closed", e.target.checked)}
                />
              </td>
              <td className="border p-2">
                <button
                  onClick={() => handleSave(slot)}
                  className="bg-pink-600 text-white px-3 py-1 rounded hover:bg-pink-700"
                >
                  Save
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default AdminSlots;
