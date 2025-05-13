import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_screen.dart';
import 'about_page.dart';
import 'contact_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.purple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                FadeInDown(
                  child: Image.asset(
                    'assets/logo.png',
                    height: 150,
                    width: 150,
                  ),
                ),
                const SizedBox(height: 20),
                // App Title
                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    'Driver Reputation Passport',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                // App Description
                FadeInUp(
                  child: Text(
                    'A blockchain-based solution to securely store and access driver, vehicle, and accident history data. Ensure transparency and trust in driver reputation management.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                // Navigation Buttons
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: _buildButton(
                    context,
                    'View Driver Data',
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DataScreen()),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: _buildButton(
                    context,
                    'About Us',
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutPage()),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: _buildButton(
                    context,
                    'Contact Us',
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ContactPage()),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade600, Colors.purple.shade600],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}