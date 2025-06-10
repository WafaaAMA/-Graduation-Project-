import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/Presentation/cubit/auth_cubit_cubit.dart';
import 'package:medical_center/Presentation/ui/auth/forget_password.dart';
import 'package:medical_center/Presentation/ui/auth/signup_screen.dart';
import 'package:medical_center/Presentation/ui/auth/signup_sucess.dart';
import 'package:medical_center/Presentation/ui/auth/success_login.dart';
// import 'package:medical_center/Presentation/ui/auth/success_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  String? _emailError;
  String? _passwordError;
  int _failedAttempts = 0;
  bool _isLocked = false;
  int _lockoutSeconds = 0;
  AnimationController? _timerController;

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _timerController?.addListener(() {
      setState(() {
        _lockoutSeconds = (30 - _timerController!.value * 30).ceil();
        if (_lockoutSeconds <= 0) {
          _isLocked = false;
          _failedAttempts = 0;
          _timerController?.stop();
        }
      });
    });
  }

  @override
  void dispose() {
    _timerController?.dispose();
    super.dispose();
  }

  void _startLockoutTimer() {
    setState(() {
      _isLocked = true;
      _lockoutSeconds = 30;
    });
    _timerController?.reset();
    _timerController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is AUthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login Success")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SuccessPage()),
          );
        } else if (state is AuthError) {
          setState(() {
            _emailError = null;
            _passwordError = null;
            if (state.message.toLowerCase().contains('invalid user data')) {
              _emailError = 'Invalid user data';
              _passwordError = 'Invalid user data';
              _failedAttempts++;
              if (_failedAttempts >= 3) {
                _startLockoutTimer();
              }
            }
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: context.read<AuthCubit>().email,
                        enabled: !_isLocked,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          errorText: _emailError,
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                        keyboardType: TextInputType.emailAddress,
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
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: context.read<AuthCubit>().password,
                        enabled: !_isLocked,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Enter your password",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: _isLocked
                                ? null
                                : () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          errorText: _passwordError,
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  ForgotPasswordScreen()),
                            );
                          },
                          child: Text(
                            _isLocked
                                ? "Too many attempts. Try forgot password?"
                                : "Forgot your password?",
                            style: TextStyle(
                              color: _isLocked ? Colors.red : const Color(0xFF199A8E),
                            ),
                          ),
                        ),
                      ),
                      if (_isLocked)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Please wait $_lockoutSeconds seconds",
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 10),
                      state is AuthLoading
                          ? const CircularProgressIndicator()
                          : MaterialButton(
                              color: const Color(0xFF199A8E),
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              onPressed: _isLocked
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _emailError = null;
                                          _passwordError = null;
                                        });
                                        context.read<AuthCubit>().signIn();
                                      }
                                    },
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                            ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupScreen()),
                              );
                            },
                            child: const Text(
                              "Sign Up",
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
              ),
            ),
          ),
        );
      },
    );
  }
}
