import React, { useEffect, useState } from "react";
import axios from "axios";

const AdminBookings = () => {
  const token = localStorage.getItem("adminToken");
  const [bookings, setBookings] = useState([]);

  const fetchBookings = async () => {
    const res = await axios.get("http://localhost:5000/api/admin/bookings", {
      headers: { Authorization: token },
    });
    setBookings(res.data);
  };

  useEffect(() => {
    fetchBookings();
  }, []);

  return (
    <div className="max-w-5xl mx-auto mt-8 p-6 bg-white rounded-2xl shadow-md">
      <h2 className="text-2xl font-bold text-pink-600 mb-4 text-center">All Bookings</h2>
      <table className="w-full border">
        <thead>
          <tr className="bg-pink-100">
            <th className="border p-2">Date</th>
            <th className="border p-2">Time</th>
            <th className="border p-2">Patient Email</th>
            <th className="border p-2">Payment</th>
            <th className="border p-2">Meeting Link</th>
            <th className="border p-2">Prescription</th>
          </tr>
        </thead>
        <tbody>
          {bookings.map(b => (
            <tr key={b.id}>
              <td className="border p-2">{b.date}</td>
              <td className="border p-2">{b.start_time} - {b.end_time}</td>
              <td className="border p-2">{b.user_email}</td>
              <td className={`border p-2 ${b.payment_status==='success'?'text-green-600':'text-red-600'}`}>{b.payment_status}</td>
              <td className="border p-2">{b.meeting_link}</td>
              <td className="border p-2">
                <input type="text" placeholder="Enter prescription" className="border p-1 rounded w-full"/>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default AdminBookings;
