import 'package:flutter/material.dart';
import 'package:medical_center/Presentation/ui/home/doctor_appointment.dart';
import 'package:medical_center/Presentation/ui/home/nurse_appointment.dart';
import 'package:medical_center/Presentation/ui/profile/user_profile_screen.dart';
import 'package:medical_center/Presentation/ui/symptom_checker/symptom_checker_screen.dart';
// import 'package:medical_center/Presentation/ui/auth/user_profile_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF199A8E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "CareFirst",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to your Medical Center",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                childAspectRatio: 0.80,
                children: [
                  _buildCard(
                    context,
                    "Doctor Appointment",
                    "assets/home_screen/doctor_appointment.jpg",
                    '/doctor-appointment',
                  ),
                  _buildCard(
                    context,
                    "Nurse Appointment",
                    "assets/home_screen/Nurse_appointment.jpg",
                    '/nurse-appointment',
                  ),
                  _buildCard(
                    context,
                    "Symptom to Diagnosis",
                    "assets/home_screen/symptom_to_diagnosis.jpg",
                    '/symptom-checker',
                  ),
                  _buildCard(
                    context,
                    "Guidance & Awareness",
                    "assets/home_screen/guidance_and_awareness.jpg",
                    '/guidance-awareness',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF199A8E),
        unselectedItemColor: Colors.grey,
        iconSize: 30,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserProfileScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    String imageUrl,
    String route,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF199A8E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: () {
                Navigator.pushNamed(context, route);
              },
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}