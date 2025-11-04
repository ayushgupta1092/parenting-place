import React, { useEffect, useState } from "react";
import axios from "axios";

const AdminRevenue = () => {
  const token = localStorage.getItem("adminToken");
  const [revenue, setRevenue] = useState(0);

  const fetchRevenue = async () => {
    const res = await axios.get("http://localhost:5000/api/admin/revenue", {
      headers: { Authorization: token },
    });
    setRevenue(res.data.totalRevenue);
  };

  useEffect(() => { fetchRevenue(); }, []);

  return (
    <div className="max-w-2xl mx-auto mt-8 p-6 bg-white rounded-2xl shadow-md text-center">
      <h2 className="text-2xl font-bold text-pink-600 mb-4">Total Revenue</h2>
      <p className="text-3xl font-semibold">₹{revenue}</p>
    </div>
  );
};

export default AdminRevenue;
