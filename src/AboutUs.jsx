import React from "react";

const AboutUs = () => {
  return (
    <div className="min-h-screen bg-white text-gray-800 py-12 px-4">
      <div className="mx-auto max-w-4xl">

        {/* Header */}
        <h1 className="text-4xl font-bold text-pink-600 mb-8 text-center">About Us</h1>

        {/* Intro */}
        <p className="text-lg leading-relaxed text-gray-700 mb-10 text-center">
          Welcome to <strong>Aarambh Thrive</strong>.  
          Our mission is to support families with expert-led care in child development, neuro-rehabilitation and parenting guidance.
        </p>

        {/* Doctor Profile */}
        <div className="bg-pink-50 rounded-2xl p-8 flex flex-col md:flex-row items-center space-y-6 md:space-y-0 md:space-x-8">
          <img
            src="/profile.jpg"
            alt="Dr. Minakshi Mohanty"
            className="w-40 h-40 md:w-56 md:h-56 object-cover rounded-2xl shadow-lg border-4 border-white mx-auto"
          />
          <div className="text-left">
            <h2 className="text-2xl font-semibold text-pink-600 mb-2">Dr. Minakshi Mohanty</h2>
            <p className="text-gray-700 mb-4">
              Rehabilitation & Child Development Specialist with 7+ years of experience working with NICU cases, neuro-divergent & developmental disorders.
            </p>
            <p className="text-gray-700">
              Recognised as a <strong>Neurodiverse Expert</strong>, Dr. Mohanty brings compassionate, evidence-based care and a personalised approach to every family she serves.
            </p>
          </div>
        </div>

        {/* Highlights / Credentials */}
        <div className="mt-12 text-left">
          <h3 className="text-xl font-semibold text-pink-600 mb-4">Professional Highlights</h3>
          <ul className="list-disc list-inside text-gray-700 space-y-2">
            <li>Pan-India Clinical Practice Lead at GiftAbled (Jun 2024 – Present)</li>
            <li>Rehabilitation & Child Development Consultant (Mar 2020 – Present)</li>
            <li>Guest Professor at Sri Devaraj Urs Medical College (2023)</li>
            <li>Doctorate from The West Bengal University of Health Sciences (2014-2019)</li>
          </ul>
        </div>

        {/* Footer note */}
        <p className="mt-12 text-center text-sm text-gray-500">
          © 2025 Aarambh Thrive. All rights reserved.
        </p>

      </div>
    </div>
  );
};

export default AboutUs;
