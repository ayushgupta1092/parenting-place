import TipsTicker from "./components/TipsTicker";  // adjust path if needed
import React from "react";
import { Button } from "./components/ui/button"; // Adjust if path differs
import { Card, CardHeader, CardContent } from "./components/ui/card";
import { useNavigate } from "react-router-dom";

const HomePage = () => {
  const navigate = useNavigate();
  const isLoggedIn = Boolean(localStorage.getItem("token"));

  const handleBookNow = () => {
    if (isLoggedIn) {
      navigate("/book-session");
    } else {
      navigate("/login");
    }
  };

  return (
    <main className="min-h-screen bg-gray-50 text-gray-800">
      {/* Hero Section */}
      <section className="bg-gradient-to-r from-pink-200 via-purple-200 to-blue-200 py-20 text-center">
        <h1 className="text-5xl font-bold mb-4">
          Welcome to Aarambh Thrive 👨‍👩‍👧‍👦
        </h1>
        <p className="text-xl mb-6">
          Helping parents raise happy, healthy, and smart kids
        </p>
        {isLoggedIn && (
          <Button
            onClick={handleBookNow}
            className="text-lg px-6 py-2 rounded-xl bg-pink-500 hover:bg-pink-600 text-white"
          >
            Book
          </Button>
        )}
      </section>

      {/* Tips Section */}
      <section id="tipsSection" className="my-4">
        <TipsTicker />
      </section>

      {/* Features / Activities Section */}
      <section id="featuresSection" className="py-16 px-6 bg-white">
        <h2 className="text-3xl font-bold text-center mb-10">
          What You'll Find Here
        </h2>
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          <Card>
            <CardContent>
              <h3 className="text-xl font-semibold mb-2">👶 Toddler Videos</h3>
              <p>Fun, colorful, and educational content designed to entertain and teach.</p>
            </CardContent>
          </Card>
          <Card>
            <CardContent>
              <h3 className="text-xl font-semibold mb-2">🧠 Parenting Tips</h3>
              <p>Get expert-backed advice on parenting challenges and milestones.</p>
            </CardContent>
          </Card>
          <Card>
            <CardContent>
              <h3 className="text-xl font-semibold mb-2">🎨 Activities & Games</h3>
              <p>Printable activities, interactive games, and DIY fun for kids.</p>
            </CardContent>
          </Card>
        </div>
      </section>

      {/* Video / Media Section */}
      <section className="py-12 px-6 bg-blue-50 text-center">
        <h2 className="text-3xl font-bold mb-6">See What We Create</h2>
        <div className="max-w-4xl mx-auto">
          <iframe
            className="w-full h-64 sm:h-96 rounded-xl shadow-lg"
            src="https://www.youtube.com/embed/EvcvMkzE2Oc"
            title="Toddler Video Sample"
            allowFullScreen
          ></iframe>
        </div>
      </section>

      {/* CTA Section */}
      <section className="text-center py-10 bg-pink-100">
        <h2 className="text-2xl font-bold mb-4">Join the Parenting Community</h2>
        <p className="mb-6">Sign up for personalized content and updates.</p>
        <Button className="bg-purple-600 hover:bg-purple-700 text-white px-6 py-2 rounded-xl">
          Register Now
        </Button>
      </section>

      {/* Footer */}
      <footer className="bg-gray-100 text-center py-6 mt-10">
        <p className="text-sm text-gray-500">
          © 2025 Aarambh Thrive. All rights reserved.
        </p>
      </footer>
    </main>
  );
};

export default HomePage;
