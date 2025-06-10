import 'package:flutter/material.dart';
import 'package:medical_center/Presentation/ui/nurse_appointment/book_nurse.dart';

class NurseSelectionScreen extends StatelessWidget {
  final List<Map<String, String>> nurses = [
    {"name": "Ali Khaled", "age": "28", "image": "assets/nurse/ali.jpg"},
    {"name": "Mazen Khaled", "age": "27", "image": "assets/nurse/mazen.jpg"},
    {"name": "Toka Ayman", "age": "25", "image": "assets/nurse/toka.jpg"},
    {"name": "Ali Ayman", "age": "35", "image": "assets/nurse/ali2.jpg"},
    {"name": "Sara Ahmed", "age": "30", "image": "assets/nurse/sara.jpg"},
    {"name": "Omar Hassan", "age": "29", "image": "assets/nurse/omar.jpg"},
    {"name": "Nora Mohamed", "age": "26", "image": "assets/nurse/nora.jpg"},
    {"name": "Mai Mostafa", "age": "32", "image": "assets/nurse/mai.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Specialized Home Nurse"),backgroundColor: Color(0xFF199A8E),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65, // قللنا النسبة لتطويل الكارت
          ),
          itemCount: nurses.length,
          itemBuilder: (context, index) {
            return _buildNurseCard(
              context,
              nurses[index]["name"]!,
              nurses[index]["age"]!,
              nurses[index]["image"]!,
            );
          },
        ),
      ),
    );
  }

  Widget _buildNurseCard(BuildContext context, String name, String age, String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                height: 100, // صغّرنا الصورة
                // fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text("Name: $name",
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            Text("Age: $age",
                style: const TextStyle(fontSize: 13),
                textAlign: TextAlign.center),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF199A8E),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(35),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NurseBookingScreen(
                      name: name,
                      image: imageUrl,
                    ),
                  ),
                );
              },
              child: const Text("Booking"),
            ),
          ],
        ),
      ),
    );
  }
}
