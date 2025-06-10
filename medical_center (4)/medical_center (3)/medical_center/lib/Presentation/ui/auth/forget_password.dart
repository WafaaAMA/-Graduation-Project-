import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/Presentation/cubit/auth_cubit_cubit.dart';
import 'package:medical_center/Presentation/ui/auth/verification.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _showEmailError = false; // لإظهار رسالة الخطأ

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is SendOtpSuccess) {
          print('OTP sent successfully, navigating to VerificationScreen');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerificationScreen()),
          );
        } else if (state is SendOtpError) {
          print('Failed to send OTP: ${state.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send OTP: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 120),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Forgot Your Password?",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Enter your email to receive a verification code",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      ),
                    ),

                    // ✅ رسالة الخطأ
                    if (_showEmailError)
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please enter your email',
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),

                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: state is SendOtpLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                if (_controller.text.isNotEmpty) {
                                  setState(() {
                                    _showEmailError = false;
                                  });
                                  print('Requesting OTP for email: ${_controller.text}');
                                  context.read<AuthCubit>().sendOtp(
                                        isEmail: true,
                                        input: _controller.text.trim(),
                                      );
                                } else {
                                  setState(() {
                                    _showEmailError = true;
                                  });
                                  print('Input is empty');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF199A8E),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "Send Verification Code",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
