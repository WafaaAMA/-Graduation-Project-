import 'package:flutter/material.dart';
import 'package:medical_center/Presentation/ui/home/home_screen.dart';
import 'package:medical_center/Presentation/ui/nurse_appointment/nurse_details.dart';
// import 'package:medical_center/Presentation/ui/nurse_appointment/nurse_selection_screen.dart';

class NurseAppointmentDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF199A8E),
        title: const Text("Nurse Appointment", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/home_screen/Nurse_appointment.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Specialized Home Nurse",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF199A8E)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Focus:\nProvides advanced care for patients with specific health conditions like heart disease, diabetes, or respiratory disorders.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Duties:\n- Advanced care (e.g., injections, oxygen therapy, chemotherapy).\n- Monitoring and treating specific conditions at home.",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF199A8E),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NurseSelectionScreen()),
            );
          },
          child: const Icon(Icons.arrow_forward, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
