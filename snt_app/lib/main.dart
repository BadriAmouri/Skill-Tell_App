import 'package:flutter/material.dart';
import 'package:snt_app/Config/supabass_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:snt_app/Screens/Splash/splash_screen.dart';
import 'package:snt_app/Screens/Home/home_screen.dart';
import 'package:snt_app/Services/shared_prefs_service.dart';
import 'package:snt_app/Theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
  
  // Check login state
  final isLoggedIn = await SharedPrefsService.getIsLoggedIn();
  
  runApp(MainApp(isLoggedIn: isLoggedIn));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  
  const MainApp({
    super.key,
    required this.isLoggedIn,
  });

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
        resizeToAvoidBottomInset: true,
        body: isLoggedIn ? const HomeScreen() : const SplashScreen(),
      ),
    );
  }
}