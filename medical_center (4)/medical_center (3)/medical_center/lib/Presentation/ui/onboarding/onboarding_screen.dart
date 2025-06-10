import 'package:flutter/material.dart';
import 'package:medical_center/Presentation/ui/onboarding/welcome_screen.dart';
// import 'package:medical_center/presentation/ui/welcome/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/1onboarding.png",
      "text": "We're here to provide you with fast and reliable healthcare. Let's get started!",
    },
    {
      "image": "assets/2onboarding.png",
      "text": "You can book a nurse or doctor at your preferred time with just a few clicks.",
    },
    {
      "image": "assets/3onboarding.png",
      "text": "Simply choose your symptoms, and we'll help you identify the possible condition.",
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _onboardingData[index]["image"]!,
                    width: 250,
                    height: 300,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      _onboardingData[index]["text"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: _currentPage != _onboardingData.length - 1
                  ? TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                        );
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : Container(),
            ),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => buildIndicator(index),
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF199A8E),
                onPressed: _nextPage,
                child: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Color(0xFF199A8E): Colors.grey,
      ),
    );
  }
}
