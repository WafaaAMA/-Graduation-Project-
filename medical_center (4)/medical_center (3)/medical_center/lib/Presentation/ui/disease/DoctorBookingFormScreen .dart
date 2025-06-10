// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/services.dart';
// import 'package:medical_center/Core/api/api_consumer.dart';
// import 'package:medical_center/Core/api/dio_consumer.dart';
// import 'package:medical_center/Data/services/book_services.dart';
// import 'package:medical_center/Presentation/book_cubit/cubit/booking_cubit.dart';
// import 'package:dio/dio.dart';

// // Screen for booking a doctor
// class DoctorBookingScreen extends StatelessWidget {
//   final String doctorId;
//   final String name;

//   const DoctorBookingScreen({
//     super.key,
//     required this.doctorId,
//     required this.name,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => BookingCubit(
//         BookingService(apiConsumer: DioConsumer(dio: Dio())),
//       ),
//       child: DoctorBookingForm(
//         doctorId: doctorId,
//         name: name,
//       ),
//     );
//   }
// }

// // Form for entering booking details
// class DoctorBookingForm extends StatelessWidget {
//   final String doctorId;
//   final String name;

//   const DoctorBookingForm({
//     super.key,
//     required this.doctorId,
//     required this.name,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController nameController = TextEditingController();
//     final TextEditingController phoneController = TextEditingController();
//     final _formKey = GlobalKey<FormState>();
//     String? limitMessage;

//     // Shows a dialog with a title and message
//     void _showDialog(BuildContext context, String title, String message) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//             content: Text(message, style: const TextStyle(fontSize: 16)),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   if (title == "Booking Confirmed") {
//                     Navigator.pop(context); // Return to previous screen
//                   }
//                 },
//                 child: const Text("OK", style: TextStyle(color: Colors.teal)),
//               ),
//             ],
//           );
//         },
//       );
//     }

//     return Scaffold(
//       backgroundColor: const Color(0xFFE8F3F1),
//       appBar: AppBar(
//         title: const Text("Doctor Booking Form"),
//         backgroundColor: const Color(0xFF199A8E),
//         elevation: 0,
//       ),
//       body: BlocConsumer<BookingCubit, BookingState>(
//         listener: (context, state) {
//           if (state is BookingSuccess) {
//             print('DoctorBookingForm: Booking successful: ${state.message}');
//             _showDialog(context, "Booking Confirmed", state.message);
//             limitMessage = null;
//           } else if (state is BookingFailure) {
//             print('DoctorBookingForm: Booking failed: ${state.message}');
//             if (state.message.contains('Try again after 24 hours')) {
//               limitMessage = state.message;
//             } else {
//               _showDialog(context, "Booking Error", state.message);
//             }
//           }
//         },
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 16.0),
//                     child: TextFormField(
//                       controller: nameController,
//                       decoration: InputDecoration(
//                         labelText: "Name",
//                         labelStyle: const TextStyle(color: Color(0xFF199A8E)),
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: const BorderSide(color: Color(0xFF199A8E), width: 2),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter your name";
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 16.0),
//                     child: TextFormField(
//                       controller: phoneController,
//                       keyboardType: TextInputType.phone,
//                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                       decoration: InputDecoration(
//                         labelText: "Phone Number",
//                         labelStyle: const TextStyle(color: Color(0xFF199A8E)),
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: const BorderSide(color: Colors.teal, width: 2),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter your phone number";
//                         } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//                           return "Please enter numbers only";
//                         } else if (value.length < 10) {
//                           return "Phone number must be at least 10 digits";
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   if (limitMessage != null)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 16.0),
//                       child: Text(
//                         limitMessage!,
//                         style: const TextStyle(color: Colors.red, fontSize: 14),
//                       ),
//                     ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.teal,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                             minimumSize: const Size(150, 50),
//                           ),
//                           onPressed: state is BookingLoading
//                               ? null
//                               : () {
//                                   if (_formKey.currentState!.validate()) {
//                                     print(
//                                         'DoctorBookingForm: Booking doctor with ID: $doctorId, Name: ${nameController.text}, Phone: ${phoneController.text}');
//                                     context.read<BookingCubit>().bookDoctor(
//                                           doctorId: doctorId,
//                                           name: nameController.text,
//                                           phoneNumber: phoneController.text,
//                                         );
//                                   }
//                                 },
//                           child: state is BookingLoading
//                               ? const CircularProgressIndicator(color: Colors.white)
//                               : const Text("Confirm"),
//                         ),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                             minimumSize: const Size(150, 50),
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text("Cancel"),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }