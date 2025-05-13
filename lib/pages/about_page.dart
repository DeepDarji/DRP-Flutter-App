import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
      ),
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
            child: ListView(
              children: [
                FadeInDown(
                  child: Text(
                    'About Driver Reputation Passport',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  child: Text(
                    'Our app leverages blockchain technology to provide a secure, transparent, and tamper-proof system for managing driver reputation data. Key features include:',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                ...[
                  'Secure storage of driver and vehicle information.',
                  'Transparent accident history tracking.',
                  'Immutable records using Ethereum blockchain.',
                  'User-friendly interface for easy data access.',
                ].asMap().entries.map((entry) {
                  return FadeInUp(
                    delay: Duration(milliseconds: 100 * (entry.key + 1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20),
                FadeInUp(
                  delay: const Duration(milliseconds: 500),
                  child: Text(
                    'Our mission is to enhance road safety and trust by providing reliable driver reputation data to authorities, insurance providers, and individuals.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}