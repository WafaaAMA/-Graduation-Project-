import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/Presentation/cubit/auth_cubit_cubit.dart';
import 'package:medical_center/Presentation/ui/auth/login_screen.dart';
import 'package:medical_center/Presentation/ui/auth/signup_sucess.dart';
import 'package:medical_center/Presentation/ui/auth/success_login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isChecked = false;
  String? _selectedGender;
  bool _showTermsError = false;

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "This field is required";
            }
            return null;
          },
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: onTogglePassword,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: const Color(0xFF199A8E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Sign Up Success")),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SuccessPage()),
              );
            } else if (state is SignUpError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: context.read<AuthCubit>().name,
                      hintText: "Enter your name",
                      prefixIcon: Icons.person,
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: context.read<AuthCubit>().emailup,
                      hintText: "Enter your email",
                      prefixIcon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: context.read<AuthCubit>().passwordup,
                      hintText: "Enter your password",
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      isPasswordVisible: _isPasswordVisible,
                      onTogglePassword: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        if (value.length < 8) {
                          return "Password must be at least 8 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: context.read<AuthCubit>().confirmPassword,
                      hintText: "Confirm your password",
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      isPasswordVisible: _isConfirmPasswordVisible,
                      onTogglePassword: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm your password";
                        }
                        if (value != context.read<AuthCubit>().passwordup.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: context.read<AuthCubit>().phone,
                      hintText: "Enter your phone number",
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your phone number";
                        }
                        if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                          return "Please enter a valid phone number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: InputDecoration(
                        hintText: "Select your gender",
                        prefixIcon: const Icon(Icons.wc),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                      items: const [
                        DropdownMenuItem(value: "1", child: Text("Male")),
                        DropdownMenuItem(value: "2", child: Text("Female")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                          context.read<AuthCubit>().gender.text = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select your gender";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: context.read<AuthCubit>().age,
                      hintText: "Enter your age",
                      prefixIcon: Icons.calendar_today,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your age";
                        }
                        final age = int.tryParse(value);
                        if (age == null || age < 1 || age > 120) {
                          return "Please enter a valid age";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value!;
                              _showTermsError = false;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: "I agree to the ",
                              children: [
                                TextSpan(
                                  text: "Terms of Service",
                                  style: TextStyle(color: Color(0xFF199A8E)),
                                ),
                                TextSpan(text: " and "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(color: Color(0xFF199A8E)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_showTermsError)
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "You must agree to the terms and privacy policy.",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 10),
                    state is SignUpLoading
                        ? const CircularProgressIndicator()
                        : MaterialButton(
                            color: const Color(0xFF199A8E),
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_isChecked) {
                                  setState(() {
                                    _showTermsError = false;
                                  });
                                  context.read<AuthCubit>().signUp();
                                } else {
                                  setState(() {
                                    _showTermsError = true;
                                  });
                                }
                              }
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0xFF199A8E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
