import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();

    // Automatically navigate to profile screen after 3 seconds
    Future.delayed(const Duration(milliseconds: 5500), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF576334), // example hex background
      body: Center(
        child: Image.asset(
          'assets/images/intro_screen.gif',
          height: 250, // Increased size
          width: 250,
        ),
      ),
    );
  }

}