import React from "react";
import { useNavigate } from "react-router-dom";

const PaymentSuccess = () => {
  const navigate = useNavigate();

  return (
    <div className="flex flex-col items-center justify-center p-10">
      <h1 className="text-3xl font-bold text-green-600 mb-4">
        ✅ Payment Successful!
      </h1>
      <p className="mb-6">Your booking has been confirmed.</p>
      <button
        onClick={() => navigate("/")}
        className="bg-pink-600 text-white px-6 py-2 rounded-lg hover:bg-pink-700"
      >
        Go to Home
      </button>
    </div>
  );
};

export default PaymentSuccess;
