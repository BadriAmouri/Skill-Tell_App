import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Main100,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.Main600,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Welcome to Home Screen!',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: AppColors.Main600,
          ),
        ),
      ),
    );
  }
}
