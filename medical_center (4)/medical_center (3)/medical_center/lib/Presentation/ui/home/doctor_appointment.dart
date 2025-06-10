import 'package:flutter/material.dart';
import 'package:medical_center/Presentation/ui/disease/Allergy&Immunity.dart';
import 'package:medical_center/Presentation/ui/disease/Dermatology.dart';
import 'package:medical_center/Presentation/ui/disease/Digestive_System.dart';
import 'package:medical_center/Presentation/ui/disease/Endocrine_System.dart';
import 'package:medical_center/Presentation/ui/disease/Nervous_System.dart';

class DoctorAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doctor Appointment"),backgroundColor: Color(0xFF199A8E),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 60,
          children: [
            _buildCard(context, "Digestive System & Liver", "assets/digestive_system.jpg", DigestiveDoctorsScreen()),
            _buildCard(context, "Allergy & Immunity", "assets/allergy&immunity.jpg", AllergyDoctorsScreen()),
            _buildCard(context, "Dermatology (Skin Diseases)", "assets/dermatology.jpg", DermatologyScreen()),
            _buildCard(context, "Nervous System", "assets/nervous_system.jpg", NervousScreen()),
            _buildCard(context, "Endocrine System & Diabetes", "assets/endocrine_system.jpg", EndocrineScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String imageUrl, Widget page) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageUrl,  // استخدم Image.asset هنا للصور المحلية
                fit: BoxFit.cover,  // تأكد من أن الصورة تأخذ الحجم الكامل للبطاقة
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,  // جعل الزر يأخذ عرض البطاقة بالكامل
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF199A8E),  // لون الزر أخضر
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => page));
              },
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,  // التأكد من محاذاة النص بشكل جيد
              ),
            ),
          ),
        ],
      ),
    );
  }
}