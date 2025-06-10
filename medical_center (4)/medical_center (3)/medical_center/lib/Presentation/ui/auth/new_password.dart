import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/Presentation/cubit/auth_cubit_cubit.dart';
import 'package:medical_center/Presentation/ui/auth/login_screen.dart';
import 'package:medical_center/Presentation/ui/common/custom_button.dart';

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>(); // ✅ مفتاح الفورم للتحقق

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          print('Password reset successful, navigating to LoginScreen');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else if (state is ResetPasswordError) {
          print('Password reset failed: ${state.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password reset failed: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),

          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey, // ✅ نربط الفورم هنا
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create New Password",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Enter a new password to secure your account",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  // ✅ New Password
                  TextFormField(
                    controller: authCubit.newPassword,
                    obscureText: !_isNewPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "New Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isNewPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isNewPasswordVisible = !_isNewPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a new password";
                      }
                      if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // ✅ Confirm Password
                  TextFormField(
                    controller: authCubit.confirmNewPassword,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }
                      if (value != authCubit.newPassword.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  // ✅ الزر
                  state is ResetPasswordLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: "Create Password",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print('Submitting new password');
                              authCubit.resetPassword();
                            } else {
                              print('Form is not valid');
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
