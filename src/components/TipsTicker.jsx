import React, { useEffect, useState } from "react";
import "./TipsTicker.css";

const TipsTicker = () => {
  const [tips, setTips] = useState([]);

  useEffect(() => {
    const fetchTips = async () => {
      try {
        const response = await fetch("http://localhost:5000/api/tips");
        const data = await response.json();

        // ✅ Ensure data is an array before setting
        if (Array.isArray(data)) {
          setTips(data);
        } else if (data && Array.isArray(data.tips)) {
          // some APIs send { tips: [...] }
          setTips(data.tips);
        } else {
          console.warn("Unexpected tips response:", data);
          setTips([]); // fallback
        }
      } catch (err) {
        console.error("Error fetching tips:", err);
        setTips([]); // fallback on error
      }
    };

    fetchTips();
  }, []);

  if (!tips || tips.length === 0) {
    return null; // nothing to show (avoids crash)
  }

  return (
    <div className="ticker-container">
      <div className="ticker-text">
        {tips.map((tip, index) => (
          <span key={tip.id || index}>
            {tip.title || String(tip)}
            {index < tips.length - 1 ? " — " : ""}
          </span>
        ))}
      </div>
    </div>
  );
};

export default TipsTicker;
