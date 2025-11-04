import React, { useState, useEffect } from "react";
import axios from "axios";
import Calendar from "react-calendar";
import "react-calendar/dist/Calendar.css";
import { useNavigate } from "react-router-dom";

const serviceImages = {
  consultation: "https://img.icons8.com/color/96/000000/medical-doctor.png",
  consultation_assessment: "https://cdn-icons-png.flaticon.com/512/2910/2910773.png",
  parenting: "https://img.icons8.com/color/96/000000/family.png",
};

const BookSession = () => {
  const navigate = useNavigate();
  const [services] = useState([
    {
      type: "consultation",
      name: "Consultation",
      price: 1500,
      description: "Book a 1-hour consultation with our expert doctor.",
    },
    {
      type: "consultation_assessment",
      name: "Consultation + Assessment",
      price: 4000,
      description: "Book a 2-hour consultation along with a full assessment.",
    },
    {
      type: "parenting",
      name: "Parenting Session",
      price: 5000,
      description: "Parenting guidance session for 1-2 hours.",
    },
  ]);

  const [selectedService, setSelectedService] = useState(null);
  const [selectedDate, setSelectedDate] = useState(new Date()); // ✅ Default today
  const [slots, setSlots] = useState([]);
  const [loadingSlots, setLoadingSlots] = useState(false);

  const patientToken = localStorage.getItem("patientToken");

  // ✅ Fetch slots when service changes OR date changes
  useEffect(() => {
    if (!selectedService || !selectedDate) return;

    const fetchSlots = async () => {
  setLoadingSlots(true);
  try {
    const dateStr = selectedDate.toISOString().split("T")[0];
    const res = await axios.get(
      `http://localhost:5000/api/patient/slots?date=${dateStr}&service_type=${selectedService.type}`,
      { headers: { Authorization: patientToken } }
    );

    if (Array.isArray(res.data)) {
      // ✅ Remove duplicates based on start_time + end_time
      const uniqueSlots = [];
      const seen = new Set();

      res.data.forEach((slot) => {
        const key = `${slot.start_time}-${slot.end_time}`;
        if (!seen.has(key)) {
          seen.add(key);
          uniqueSlots.push(slot);
        }
      });

      setSlots(uniqueSlots);
    } else {
      console.error("Unexpected slot data:", res.data);
      setSlots([]);
    }
  } catch (err) {
    console.error("❌ Error fetching slots:", err);
    setSlots([]);
  } finally {
    setLoadingSlots(false);
  }
};

    fetchSlots();
  }, [selectedService, selectedDate]);

  const handleSelectSlot = (slot) => {
  const slotId = slot._id || slot.id; // handle both
  localStorage.setItem("selectedSlot", JSON.stringify(slot));
  localStorage.setItem("selectedService", JSON.stringify(selectedService));
  navigate(`/payment/${slotId}`, { state: { slot } });
};


  const handleBack = () => {
    setSelectedService(null);
    setSelectedDate(new Date());
    setSlots([]);
  };

  return (
    <div className="max-w-5xl mx-auto mt-10 p-6 bg-white rounded-2xl shadow-md">
      {!selectedService ? (
        <>
          <h2 className="text-3xl font-bold text-pink-600 mb-6 text-center">
            Book Your Session
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {services.map((svc) => (
              <div
                key={svc.type}
                className="border p-4 rounded-xl shadow hover:shadow-lg cursor-pointer transition-transform hover:-translate-y-1"
                onClick={() => setSelectedService(svc)}
              >
                <img
                  src={serviceImages[svc.type]}
                  alt={svc.name}
                  className="mx-auto mb-4 w-20 h-20"
                />
                <h3 className="text-xl font-semibold mb-2 text-center">{svc.name}</h3>
                <p className="text-center text-gray-600 mb-2">{svc.description}</p>
                <p className="text-center font-bold text-pink-600">₹{svc.price}</p>
              </div>
            ))}
          </div>
        </>
      ) : (
        <div>
          <button
            onClick={handleBack}
            className="mb-4 px-4 py-2 bg-gray-200 rounded-lg hover:bg-gray-300"
          >
            ← Back
          </button>
          <h2 className="text-2xl font-bold text-pink-600 mb-4 text-center">
            {selectedService.name}
          </h2>

          <div className="flex flex-col md:flex-row gap-6 justify-center items-start">
            <div>
              <h3 className="font-semibold text-gray-700 mb-2">Select a Date</h3>
              <Calendar
                onChange={(date) => setSelectedDate(date)}
                value={selectedDate}
                minDate={new Date()}
              />
            </div>

            <div className="flex-1">
              {selectedDate && (
                <>
                  <h3 className="font-semibold text-gray-700 mb-2 text-center">
                    Available Slots on{" "}
                    <span className="text-pink-600">{selectedDate.toDateString()}</span>
                  </h3>

                  {loadingSlots ? (
                    <p className="text-center text-gray-500">Loading slots...</p>
                  ) : slots.length > 0 ? (
                    <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
                      {slots.map((slot) => (
                        <button
                          key={slot._id}
                          disabled={slot.is_booked || slot.is_closed}
                          onClick={() => handleSelectSlot(slot)}
                          className={`p-3 rounded-lg text-center font-semibold ${
                            slot.is_booked || slot.is_closed
                              ? "bg-gray-300 text-gray-600 cursor-not-allowed"
                              : "bg-pink-100 hover:bg-pink-200 text-pink-800"
                          }`}
                        >
                          {slot.start_time.slice(0, 5)} - {slot.end_time.slice(0, 5)}
                        </button>
                      ))}
                    </div>
                  ) : (
                    <p className="text-center text-gray-500">No slots available.</p>
                  )}
                </>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default BookSession;
