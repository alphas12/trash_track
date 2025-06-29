import 'package:flutter/material.dart';
import 'package:trash_track/screens/bookmark_screen.dart';
import 'package:trash_track/screens/eco_shop_screen.dart';
import 'package:trash_track/screens/settings_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_options.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: '/bookmark',
      routes: {
        '/intro': (context) => const IntroScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/signup': (context) => const SignUpOptionsPage(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardScreen(),
        '/bookmark': (context) => const CollectionsPage(),
      },
    );
  }
}

