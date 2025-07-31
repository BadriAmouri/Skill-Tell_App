import 'package:flutter/material.dart';
import 'package:snt_app/Screens/login/login_screen.dart';
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
      theme: ThemeData(
        fontFamily: AppFonts.primaryFontFamily,
        textTheme: ThemeData.light().textTheme.apply(
          fontFamily: AppFonts.primaryFontFamily,
        ),
      ),
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
