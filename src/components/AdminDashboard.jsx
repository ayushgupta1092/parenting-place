import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import AdminSlots from "./admin/AdminSlots";
import AdminBookings from "./admin/AdminBookings";
import AdminRevenue from "./admin/AdminRevenue";

const AdminDashboard = () => {
  const [activeTab, setActiveTab] = useState("slots");
  const navigate = useNavigate();

  const handleSignOut = () => {
    localStorage.removeItem("adminToken");
    navigate("/admin-login");
  };

  const renderTab = () => {
    switch (activeTab) {
      case "slots":
        return <AdminSlots />;
      case "bookings":
        return <AdminBookings />;
      case "revenue":
        return <AdminRevenue />;
      default:
        return null;
    }
  };

  return (
    <div className="max-w-6xl mx-auto mt-8">
      {/* Header with Sign Out */}
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold text-pink-600">Doctor Admin Dashboard</h1>
        <button
          onClick={handleSignOut}
          className="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 font-semibold"
        >
          Sign Out
        </button>
      </div>

      {/* Tabs */}
      <div className="flex justify-center gap-4 mb-6">
        <button
          onClick={() => setActiveTab("slots")}
          className={`px-4 py-2 rounded-t-lg font-semibold ${
            activeTab === "slots" ? "bg-pink-600 text-white" : "bg-pink-100 text-pink-700"
          }`}
        >
          Slots
        </button>
        <button
          onClick={() => setActiveTab("bookings")}
          className={`px-4 py-2 rounded-t-lg font-semibold ${
            activeTab === "bookings" ? "bg-pink-600 text-white" : "bg-pink-100 text-pink-700"
          }`}
        >
          Bookings
        </button>
        <button
          onClick={() => setActiveTab("revenue")}
          className={`px-4 py-2 rounded-t-lg font-semibold ${
            activeTab === "revenue" ? "bg-pink-600 text-white" : "bg-pink-100 text-pink-700"
          }`}
        >
          Revenue
        </button>
      </div>

      {/* Tab Content */}
      <div className="bg-white rounded-b-2xl shadow-md p-4">{renderTab()}</div>
    </div>
  );
};

export default AdminDashboard;
