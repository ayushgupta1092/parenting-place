import React from "react";
import { useNavigate, useLocation } from "react-router-dom";
import logo from "../assets/logo.jpg";

const Header = () => {
  const navigate = useNavigate();
  const location = useLocation();
  const isLoggedIn = Boolean(localStorage.getItem("token"));

  const handleBookClick = () => {
    navigate("/book-session");
  };

  const handleSignOut = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("username");
    localStorage.removeItem("tokenExpiry");
    window.location.href = "/";
  };

  const goToTips = () => {
    navigate("/");
    setTimeout(() => {
      const el = document.getElementById("tipsSection");
      if (el) el.scrollIntoView({ behavior: "smooth" });
    }, 100);
  };

  const goToActivities = () => {
    navigate("/");
    setTimeout(() => {
      const el = document.getElementById("featuresSection");
      if (el) el.scrollIntoView({ behavior: "smooth" });
    }, 100);
  };

  return (
    <header className="flex items-center justify-between px-6 py-3 bg-white shadow-md">
      <div className="flex items-center space-x-3">
        <img
          src={logo}
          alt="Aarambh Thrive Logo"
          className="w-12 h-12 rounded-full border border-pink-400"
        />
        <div>
          <h1 className="text-2xl font-bold text-pink-600">Aarambh Thrive</h1>
          <p className="text-sm text-gray-500 font-medium">Where Every Beginning Blossoms</p>
        </div>
      </div>

      <nav className="ml-auto flex space-x-6 text-gray-600 text-base">
        <button onClick={() => navigate("/")} className="hover:text-pink-600 font-medium">
          Home
        </button>
        <button onClick={goToTips} className="hover:text-pink-600 font-medium">
          Tips
        </button>
        <button onClick={goToActivities} className="hover:text-pink-600 font-medium">
          Activities
        </button>

        {/* Only show Book link if not already on the Book Session page */}
        {location.pathname !== "/book-session" && (
          <button
            onClick={handleBookClick}
            className="hover:text-pink-600 font-medium"
          >
            Book
          </button>
        )}

        <button
          onClick={() => navigate("/about")}
          className="hover:text-pink-600 font-medium"
        >
          About
        </button>

        {isLoggedIn && (
          <button onClick={handleSignOut} className="hover:text-red-600 font-medium">
            Sign Out
          </button>
        )}
      </nav>
    </header>
  );
};

export default Header;
