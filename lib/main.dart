import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rice_app/config/app_constants.dart';
import 'package:rice_app/screens/home_screen.dart';

void main() {
  runApp(const RiceDiseaseClassifierApp());
}

class RiceDiseaseClassifierApp extends StatelessWidget {
  const RiceDiseaseClassifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rice Disease Classifier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppConstants.primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppConstants.primaryColor,
            elevation: 3,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
