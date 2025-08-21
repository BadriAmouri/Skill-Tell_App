import 'package:flutter/material.dart';
import 'package:snt_app/Screens/main_layout.dart';
import 'package:snt_app/Theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill & Tell App',
      theme: ThemeData(
        fontFamily: 'Poppins', // Set default font
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppColors.Main600,
      ),
      home: const MainLayout(),
    );
  }
}