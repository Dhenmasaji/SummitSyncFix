import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_akhir_tpm/landing.dart';
import 'package:tugas_akhir_tpm/homepage.dart';
import 'package:tugas_akhir_tpm/onboarding.dart'; // Import halaman onboarding

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final loggedIn = prefs.getBool('loggedIn') ?? false;
  final seenOnboarding = prefs.getBool('seenOnboarding') ?? true;
  runApp(MyApp(isLoggedIn: loggedIn, seenOnboarding: seenOnboarding));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool seenOnboarding;

  MyApp({required this.isLoggedIn, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? HomePage() : (seenOnboarding ? SplashScreen() : OnboardingScreen()),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logo_ob.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
