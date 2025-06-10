import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/Core/api/database/cachehelper.dart';
import 'package:medical_center/Core/api/dio_consumer.dart';
import 'package:medical_center/Data/services/book_services.dart';
import 'package:medical_center/Presentation/cubit/auth_cubit_cubit.dart';
import 'package:medical_center/Presentation/book_cubit/cubit/booking_cubit.dart';
import 'package:medical_center/Presentation/ui/home/GuidanceAndAwarenessScreen.dart';
import 'package:medical_center/Presentation/ui/onboarding/onboarding_screen.dart';
import 'package:medical_center/Presentation/ui/auth/login_screen.dart';
import 'package:medical_center/Presentation/ui/auth/signup_screen.dart';
import 'package:medical_center/Presentation/ui/home/home_screen.dart';
import 'package:medical_center/Presentation/ui/home/doctor_appointment.dart';
import 'package:medical_center/Presentation/ui/home/nurse_appointment.dart';
import 'package:medical_center/Presentation/ui/onboarding/splashscreen.dart';
import 'package:medical_center/Presentation/ui/profile/user_profile_screen.dart';
import 'package:medical_center/Presentation/ui/profile/edit_profile_screen.dart';
import 'package:medical_center/Presentation/ui/home/doctor_list_screen.dart';
import 'package:medical_center/Presentation/ui/symptom_checker/symptom_checker_screen.dart';

// Import the SplashScreen
// import 'package:medical_center/Presentation/ui/splash_screen.dart'; // Adjust the path as needed

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) => BookingCubit(
            BookingService(apiConsumer: DioConsumer(dio: Dio())),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medical Center',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFE8F3F1),
          primaryColor: const Color(0xFF199A8E),
        ),
        initialRoute: '/splash', // Set the splash screen as the initial route
        routes: {
          '/splash': (context) => const SplashScreen(), // Add the splash screen route
          '/onboarding': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) =>  HomeScreen(),
          '/profile': (context) => const UserProfileScreen(),
          '/edit-profile': (context) => const EditProfileScreen(),
          '/doctors': (context) =>  DoctorListScreen(),
          '/doctor-appointment': (context) => DoctorAppointmentScreen(),
          '/nurse-appointment': (context) =>  NurseAppointmentDetailsScreen(),
          '/symptom-checker': (context) =>  DiseasePredictionPage(),
          '/guidance-awareness': (context) => GuidanceAwarenessPage(),
        },
      ),
    );
  }
}