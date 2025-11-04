import React, { useEffect } from "react";
import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
  useLocation,
} from "react-router-dom";
import AboutUs from "./AboutUs"; 
// User Components
import Header from "./components/Header";
import HomePage from "./HomePage";
import Login from "./components/Login";
import Register from "./components/Register";
import BookSession from "./components/BookSession";
import PaymentPage from "./components/PaymentPage";
import PaymentSuccess from "./components/PaymentSuccess";

import AdminDashboard from "./components/AdminDashboard"; // <-- Dashboard with tabs
import AdminSlots from "./components/admin/AdminSlots";    // <-- Optional if used directly
import AdminBookings from "./components/admin/AdminBookings";
import AdminRevenue from "./components/admin/AdminRevenue";
// Admin Components
import AdminLogin from "./components/AdminLogin";
import AdminPage from "./components/AdminPage";

const Layout = ({ children }) => {
  const location = useLocation();
  const isAdminRoute = location.pathname.startsWith("/admin");
  return (
    <>
      {!isAdminRoute && <Header />}
      {children}
    </>
  );
};

const AppRoutes = () => {
  const isUserLoggedIn = Boolean(localStorage.getItem("token"));
  const isAdminLoggedIn = Boolean(localStorage.getItem("adminToken"));

  return (
    <Routes>
      <Route path="/" element={<HomePage />} />
      <Route path="/login" element={<Login />} />
      <Route path="/register" element={<Register />} />
      <Route
        path="/book-session"
        element={
          isUserLoggedIn ? <BookSession /> : <Navigate to="/login" replace />
        }
      />
      <Route
        path="/payment/:slotId"
        element={
          isUserLoggedIn ? <PaymentPage /> : <Navigate to="/login" replace />
        }
      />
      <Route path="/about" element={<AboutUs />} /> 
      <Route
        path="/payment-success"
        element={
          isUserLoggedIn ? <PaymentSuccess /> : <Navigate to="/login" replace />
        }
      />
      <Route path="/admin-login" element={<AdminLogin />} />
      <Route
  path="/admin"
  element={
    isAdminLoggedIn ? <AdminDashboard /> : <Navigate to="/admin-login" replace />
  }
/>

      <Route path="*" element={<Navigate to="/" replace />} />
      <Route path="/admin/slots" element={isAdminLoggedIn ? <AdminSlots /> : <Navigate to="/admin-login" replace />} />
<Route path="/admin/bookings" element={isAdminLoggedIn ? <AdminBookings /> : <Navigate to="/admin-login" replace />} />
<Route path="/admin/revenue" element={isAdminLoggedIn ? <AdminRevenue /> : <Navigate to="/admin-login" replace />} />
    </Routes>
  );
};

const App = () => {
  // Check token expiry on load
  useEffect(() => {
    const checkExpiry = () => {
      const tokenExpiry = localStorage.getItem("tokenExpiry");
      if (tokenExpiry && Date.now() > tokenExpiry) {
        localStorage.removeItem("token");
        localStorage.removeItem("username");
        localStorage.removeItem("tokenExpiry");
        window.location.href = "/";
      }
    };

    // Run once on load
    checkExpiry();

    // Listen to changes in localStorage (other tabs)
    const handleStorage = (event) => {
      if (
        event.key === "token" &&
        event.newValue === null // token removed in another tab
      ) {
        window.location.href = "/";
      }
    };

    window.addEventListener("storage", handleStorage);

    // Optional: check every minute in case user stays on same tab
    const interval = setInterval(checkExpiry, 60 * 1000);

    return () => {
      window.removeEventListener("storage", handleStorage);
      clearInterval(interval);
    };
  }, []);

  return (
    <Router>
      <Layout>
        <AppRoutes />
      </Layout>
    </Router>
  );
};

export default App;
