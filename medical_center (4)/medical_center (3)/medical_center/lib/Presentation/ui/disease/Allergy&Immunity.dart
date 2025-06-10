import 'package:flutter/material.dart';
import 'package:medical_center/Presentation/ui/disease/DoctorBookingFormScreen%20.dart';
import 'package:medical_center/Presentation/ui/disease/book_doctor.dart';

class AllergyDoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Allergy & Immunity",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFF199A8E),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDoctorCard(
            "Dr. Khaled Ali",
            "Consultant in Allergy and Immunology, graduate of Cairo University, specializing in the treatment of asthma, seasonal allergies, and autoimmune disorders.",
            "Saturday to Thursday: 11:00 AM - 3:00 PM",
            "Friday: Closed",
            "assets/Khaled1.jpg",
            context,
            4,
          ),
          const SizedBox(height: 20),
          _buildDoctorCard(
            "Dr. Ahmed Mostafa",
            "Specialist in Allergy and Immunology, trained at Harvard University, with expertise in food allergies and autoimmune diseases.",
            "Saturday to Thursday: 4:00 PM - 8:00 PM",
            "Friday: Closed",
            "assets/Ahmed.jpg",
            context,
            5,
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(String name, String details, String timing, String closed, String imageUrl, BuildContext context, int rating) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Text(
                  details,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 12),
                Text(
                  timing,
                  style: const TextStyle(color: Colors.teal, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  closed,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF199A8E),
                    ),
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
