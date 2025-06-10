import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_center/Presentation/ui/nurse_appointment/booking_success.dart';

class NurseBookingScreen extends StatelessWidget {
  final String name;
  final String image;

  const NurseBookingScreen({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFFE8F3F1),
      appBar: AppBar(
        title: const Text("Nurse Booking Form"),
        backgroundColor: const Color(0xFF199A8E),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // صورة الممرضة
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    image,
                    width: 150,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                // اسم الممرضة
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // حقل الاسم
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Your Name",
                      labelStyle: const TextStyle(color: Color(0xFF199A8E)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xFF199A8E), width: 2),
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

                // حقل رقم الهاتف
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: const TextStyle(color: Color(0xFF199A8E)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xFF199A8E), width: 2),
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

                // الأزرار
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF199A8E),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          minimumSize: const Size(150, 50),
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
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: () => Navigator.pop(context),
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
