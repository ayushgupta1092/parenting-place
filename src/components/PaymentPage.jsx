import React, { useState, useEffect } from "react";
import axios from "axios";
import { useNavigate, useParams } from "react-router-dom";

const PaymentPage = () => {
  const navigate = useNavigate();
  const { slotId } = useParams();
  const [slot, setSlot] = useState(null);
  const [service, setService] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const s = localStorage.getItem("selectedSlot");
    const svc = localStorage.getItem("selectedService");
    if (s && svc) {
      setSlot(JSON.parse(s));
      setService(JSON.parse(svc));
    }
  }, []);

  const handlePaid = async () => {
  if (!slot || !service) {
    alert("Missing slot or service info!");
    return;
  }

  setLoading(true);
  try {
    const userId = localStorage.getItem("userId") || "1";
    const slotIdValue = slot.id || slot._id || slotId;

    const response = await axios.post("http://localhost:5000/api/payment", {
      userId,
      slotId: slotIdValue,
      amount: service.price,
      note: `Paid for ${service.name} slot on ${slot.slot_date}`,
    });

    if (response.data.success) {
      alert("✅ Payment recorded! Your slot is booked.");
      localStorage.removeItem("selectedSlot");
      localStorage.removeItem("selectedService");
      navigate("/payment-success");
    } else {
      throw new Error(response.data.message || "Payment failed");
    }
  } catch (err) {
    console.error("Payment error:", err);
    alert("❌ Payment failed to record. Please try again.");
  } finally {
    setLoading(false);
  }
};

  if (!slot || !service)
    return <p className="text-center mt-10">No session selected.</p>;

  return (
    <div className="max-w-md mx-auto mt-12 p-6 bg-white shadow rounded-2xl text-center">
      <h2 className="text-2xl font-bold text-pink-600 mb-2">Complete Payment</h2>
      <p className="mb-4">Service: <b>{service.name}</b></p>
      <p className="mb-6 text-lg">Amount: <b>₹{service.price}</b></p>

      {/* Static QR code */}
      <img
        src="/upi_qr.png"
        alt="UPI QR"
        className="mx-auto w-60 h-60 border p-2 mb-6 rounded"
      />

      <p className="text-gray-600 mb-6">
        Scan this QR using any UPI app and pay the exact amount.<br />
        After payment, click below to confirm.
      </p>

      <button
        onClick={handlePaid}
        disabled={loading}
        className="bg-green-500 hover:bg-green-600 text-white px-6 py-2 rounded-full"
      >
        {loading ? "Recording..." : "I Have Paid"}
      </button>
    </div>
  );
};

export default PaymentPage;
