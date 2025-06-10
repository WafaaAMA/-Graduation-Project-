
import 'package:flutter/material.dart';
import 'package:medical_center/Presentation/ui/disease/DoctorBookingFormScreen%20.dart';
import 'package:medical_center/Presentation/ui/disease/book_doctor.dart';

class DigestiveDoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Digestive System & Liver", ),backgroundColor: Color(0xFF199A8E),),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDoctorCard(
            "Dr. Khaled Al Sharif",
            "PhD and Consultant of Gastroenterology, Liver and Endoscopy at Kasr Al Ainy Faculty of Medicine",
            "Saturday to Thursday: 11:00 AM - 3:00 PM",
            "Friday: Closed",
            "assets/Khaled1.jpg",
            context,
            4, // Rating 4 stars
          ),
          const SizedBox(height: 20),
          _buildDoctorCard(
            "Dr. Mai Amer",
            "Critical liver disease cases - Treatment of liver tumors\nTreatment of digestive system diseases. And bleeding cases",
            "Saturday to Thursday: 4:00 PM - 8:00 PM",
            "Friday: Closed",
            "assets/Mona.jpg",
            context,
            5, // Rating 5 stars
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(String name, String details, String timing, String closed, String imageUrl, BuildContext context, int rating) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image at the top of the card
            ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.contain, // Ensure the image fits without cutting
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor's name and rating
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF199A8E),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Display rating stars
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Doctor's details
                Text(
                  details,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 12),
                // Working hours and closed day
                Text(
                  timing,
                  style: const TextStyle(
                    color: Color(0xFF199A8E),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  closed,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
                const SizedBox(height: 20),
                // Booking button that navigates to the booking form
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF199A8E)),

                  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorBookingFormScreen(
                            doctorName: name,
                            doctorImage: imageUrl,
                          ),
                        ),
                      );
                    },
                    child: const Text("Booking", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}