import React, { useState } from "react";
import axios from "axios";

const AdminLogin = () => {
  const [form, setForm] = useState({ username: "", password: "" });
  const [error, setError] = useState("");

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const res = await axios.post("http://localhost:5000/api/admin/login", form);
      localStorage.setItem("adminToken", res.data.token);
      const expiryTime = Date.now() + 60 * 60 * 1000;
      localStorage.setItem("adminTokenExpiry", expiryTime);

      // ✅ Force redirect
      window.location.href = "/admin";
    } catch (err) {
      setError(err.response?.data?.message || "Login failed");
    }
  };

  return (
    <div className="flex justify-center items-center h-screen bg-pink-100">
      <form
        onSubmit={handleLogin}
        className="bg-white p-8 rounded-2xl shadow-md w-96 space-y-4"
      >
        <h2 className="text-2xl font-bold text-pink-600 text-center">Admin Login</h2>
        <input
          type="text"
          placeholder="Username"
          value={form.username}
          onChange={(e) => setForm({ ...form, username: e.target.value })}
          className="w-full border p-2 rounded-lg"
          required
        />
        <input
          type="password"
          placeholder="Password"
          value={form.password}
          onChange={(e) => setForm({ ...form, password: e.target.value })}
          className="w-full border p-2 rounded-lg"
          required
        />
        {error && <p className="text-red-600 text-center">{error}</p>}
        <button className="w-full bg-pink-600 text-white py-2 rounded-lg hover:bg-pink-700">
          Login
        </button>
      </form>
    </div>
  );
};

export default AdminLogin;
