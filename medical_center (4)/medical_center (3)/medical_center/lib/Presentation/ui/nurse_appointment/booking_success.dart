import 'package:flutter/material.dart';
import 'package:medical_center/presentation/ui/home/home_screen.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // لون خلفية خفيف
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle,
                    size: 100, color: Color(0xFF009688)),
            const SizedBox(height: 20),
            const Text(
              "Booking Successful!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Your appointment has been confirmed.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "The CareFirst team will contact you soon for confirmation.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF199A8E),
                foregroundColor: Colors.white,
                elevation: 5,
                shadowColor: Colors.black45,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}