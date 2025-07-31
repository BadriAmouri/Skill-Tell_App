import 'package:flutter/material.dart';
import 'package:snt_app/widgets/custom_button.dart';
import 'package:snt_app/Screens/signup/signup_screen.dart';
import 'package:snt_app/Screens/login/login_screen.dart';
import 'package:snt_app/Theme/theme.dart';
class CustomScaffold extends StatelessWidget {
  final Widget? child;
  const CustomScaffold({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'lib/Assets/images/Splash-screen.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top:30,
                        left:30,
                        right:30,
                        bottom:0,
                      ),
                      child: Image.asset(
                        'lib/Assets/images/logo.png',
                        height: 250,
                        width: 200,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 14,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 60.0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: CustomButton(
                                        onTap: SignupScreen(),
                                        color: Colors.white,
                                        buttonText: "Sign up",
                                        textColor:AppColors.Text300,
                                      ),
                                    ),
                                    const Expanded(
                                      child: CustomButton(
                                        onTap: LoginScreen(),
                                        color: Colors.white,
                                        buttonText: "Login",
                                        textColor: AppColors.Main400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: child!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
            ), 
          ),
        ],
      ),
    );
  }
}
