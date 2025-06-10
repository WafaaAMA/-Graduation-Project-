import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_center/Presentation/ui/nurse_appointment/booking_success.dart';

class DoctorBookingFormScreen extends StatefulWidget {
  final String doctorName;
  final String doctorImage;

  const DoctorBookingFormScreen({
    required this.doctorName,
    required this.doctorImage,
  });

  @override
  _DoctorBookingFormScreenState createState() => _DoctorBookingFormScreenState();
}

class _DoctorBookingFormScreenState extends State<DoctorBookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message, style: TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text("OK", style: TextStyle(color: Color(0xFF199A8E))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F3F1),
      appBar: AppBar(
        title: const Text("Doctor Booking Form"),
        backgroundColor: Color(0xFF199A8E), // تغير اللون للأخضر
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // جعل النصوص في الوسط
              children: [
                // صورة الدكتور في border
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.doctorImage,
                    width: 150,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                // اسم الدكتور تحت الصورة
                Text(
                  widget.doctorName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // هنا تم تصحيح المشكلة
                ),
                const SizedBox(height: 20),
        
                // حقل الاسم
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Your Name",
                      labelStyle: TextStyle(color: Color(0xFF199A8E)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF199A8E), width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                ),
        
                // حقل الهاتف
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: TextStyle(color: Color(0xFF199A8E)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF199A8E), width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone number";
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return "Please enter only numbers";
                      } else if (value.length < 10) {
                        return "Phone number must be at least 10 digits";
                      }
                      return null;
                    },
                  ),
                ),
        
                // الأزرار لتأكيد أو إلغاء
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF199A8E),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          minimumSize: Size(150, 50),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const BookingSuccessScreen()),
                            );
                          }
                        },
                        child: const Text("Confirm"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          minimumSize: Size(150, 50),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
