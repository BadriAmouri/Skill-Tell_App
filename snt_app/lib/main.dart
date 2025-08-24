import 'package:flutter/material.dart';
import 'package:snt_app/Config/supabass_config.dart';
import 'package:snt_app/Screens/Home/home_screen.dart';
import 'package:snt_app/Screens/signup/create_password.dart';
import 'package:snt_app/Screens/signup/otpcode_verification.dart';
import 'package:snt_app/Screens/signup/signup_screen.dart';
import 'package:snt_app/Screens/signup/your_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:snt_app/Screens/Splash/splash_screen.dart';
import 'package:snt_app/Theme/theme.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  
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

        // body: SplashScreen(),
        body: SignupScreen()
      ),

    );
  }
}
