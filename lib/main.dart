import 'package:flutter/material.dart';
import 'home_screen.dart';

// Entry point of the Flutter application
void main() {
  runApp(const DriverReputationApp());
}

// Main application widget
class DriverReputationApp extends StatelessWidget {
  const DriverReputationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver Reputation Passport', // App title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set primary color theme
        scaffoldBackgroundColor: Colors.grey[100], // Light background
      ),
      home: const HomeScreen(), // Set HomeScreen as the initial screen
    );
  }
}