import 'package:flutter/material.dart';
import 'package:medical_center/Presentation/ui/disease/DoctorBookingFormScreen%20.dart';
import 'package:medical_center/Presentation/ui/disease/book_doctor.dart';

class DermatologyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dermatology (Skin Diseases)",),
      backgroundColor: const Color(0xFF199A8E),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDoctorCard(
            "Dr. Amnia Mohammed",
            "Dermatologist, graduate of Ain Shams University, specializing in acne, eczema, and dermatologic surgery.",
            "Saturday to Thursday: 11:00 AM - 3:00 PM",
            "Friday: Closed",
            "assets/Amnia.jpg", // تأكد من أن الصورة موجودة
            context,
            4, // التقييم 4 نجوم
          ),
          const SizedBox(height: 20), // مساحة بين بطاقات الأطباء
          _buildDoctorCard(
            "Dr. Eman Ali",
            "Consultant in Dermatology, trained at Cleveland University, specializing in laser treatments and pigmentation disorders.",
            "Saturday to Thursday: 4:00 PM - 8:00 PM",
            "Friday: Closed",
            "assets/Amira.jpg", // تأكد من أن الصورة موجودة
            context,
            5, // التقييم 5 نجوم
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(String name, String details, String timing, String closed, String imageUrl, BuildContext context, int rating) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5, // إضافة الظل لزيادة العمق
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة كاملة العرض في الأعلى
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
            padding: const EdgeInsets.all(13), // padding الداخلي لمحتوى البطاقة
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // اسم الطبيب مع التقييم
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
                    // النجوم للتقييم
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
                // تفاصيل الطبيب
                Text(
                  details,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 12),
                // ساعات العمل واليوم المغلق
                Text(
                  timing,
                  style: const TextStyle(color:Color(0xFF199A8E), fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  closed,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
                const SizedBox(height: 20),
                // زر الحجز الذي ينقل إلى صفحة الحجز
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF199A8E),),
                    onPressed: () {
                      // التنقل إلى صفحة نموذج الحجز مع بيانات الطبيب
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
