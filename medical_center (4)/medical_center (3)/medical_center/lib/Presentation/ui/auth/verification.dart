import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/Presentation/cubit/auth_cubit_cubit.dart';
import 'package:medical_center/Presentation/ui/auth/new_password.dart';
import 'package:medical_center/Presentation/ui/common/custom_button.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(5, (_) => TextEditingController());

  bool _showOtpError = false; // لعرض رسالة الخطأ

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccess) {
          print('OTP verification successful, navigating to NewPasswordScreen');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewPasswordScreen()),
          );
        } else if (state is VerifyOtpError) {
          print('OTP verification failed: ${state.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter Verification Code",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter the 5-digit code sent to your email",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Container(
                          width: 45,
                          height: 45,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 1.5),
                          ),
                          child: TextField(
                            controller: _otpControllers[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                            ),
                            onChanged: (value) {
                              if (value.length == 1 && index < 4) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ✅ رسالة الخطأ تحت الحقول
                  if (_showOtpError)
                    const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        'Please enter all 5 digits',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),

                  const SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: state is VerifyOtpLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              text: "Verify",
                              onPressed: () {
                                final otp = _otpControllers.map((c) => c.text).join();
                                if (otp.length == 5) {
                                  setState(() {
                                    _showOtpError = false;
                                  });
                                  print('Submitting OTP: $otp');
                                  context.read<AuthCubit>().verifyOtp(otp);
                                } else {
                                  setState(() {
                                    _showOtpError = true;
                                  });
                                  print('Invalid OTP length');
                                }
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
