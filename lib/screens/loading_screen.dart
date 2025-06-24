import 'package:flutter/material.dart';
import 'dart:async';
import 'dashboard_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 5500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF576334),
      body: Center(
        child: Image.asset(
          'assets/images/loading_screen.gif',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}