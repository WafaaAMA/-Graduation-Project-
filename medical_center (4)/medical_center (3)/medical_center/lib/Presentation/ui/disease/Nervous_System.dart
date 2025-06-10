import 'package:flutter/material.dart';
import 'package:medical_center/Presentation/ui/disease/DoctorBookingFormScreen%20.dart';
import 'package:medical_center/Presentation/ui/disease/book_doctor.dart';
//import 'package:medical_center/Presentation/ui/disease/DoctorBookingFormScreen.dart'; // تأكد من أن الرابط صحيح

class NervousScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nervous System"),
      backgroundColor: const Color(0xFF199A8E),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDoctorCard(
            "Dr. Mona Al Sharif",
            "Consultant Neurologist, PhD from Cairo University, specializing in the treatment of migraines, multiple sclerosis, and neurological disorders.",
            "Saturday to Thursday: 11:00 AM - 3:00 PM",
            "Friday: Closed",
            "assets/Mona.jpg", // Sample image URL
            context,
            4, // Rating 4 stars
          ),
          const SizedBox(height: 20), // Space between the doctor cards
          _buildDoctorCard(
            "Dr. Amira Amer",
            "Neurologist, graduate of Johns Hopkins University, specializing in movement disorders and stroke rehabilitation.",
            "Saturday to Thursday: 4:00 PM - 8:00 PM",
            "Friday: Closed",
            "assets/Amira.jpg", // Sample image URL
            context,
            5, // Rating 5 stars
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(String name, String details, String timing, String closed, String imageUrl, BuildContext context, int rating) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5, // Add shadow for depth
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full-width image at the top
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
            padding: const EdgeInsets.all(16), // Inner padding for the card content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor's name with rating stars
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
                    const SizedBox(width: 8),
                    // Rating stars
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
                  style: const TextStyle(color: Color(0xFF199A8E), fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  closed,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF199A8E),),
                    onPressed: () {
                      // Navigate to the booking form screen with doctor info
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
