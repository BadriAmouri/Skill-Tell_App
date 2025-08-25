import 'package:flutter/material.dart';
import 'package:snt_app/Widgets/SignUp&LogIn/custom_button.dart';
import 'package:snt_app/Screens/signup/signup_screen.dart';
import 'package:snt_app/Screens/login/login_screen.dart';
import 'package:snt_app/Theme/theme.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? child;
  final bool isLogin;
  final bool zoomheight;

  const CustomScaffold({
    super.key,
    required this.child,
    this.isLogin = true,
    this.zoomheight = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // background
          Image.asset(
            'lib/Assets/Images/Splash-screen.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // logo section
                        Padding(
                          padding: EdgeInsets.only(
                            top: !zoomheight ? 30 : 0,
                            left: !zoomheight ? 30 : 0,
                            right: !zoomheight ? 30 : 0,
                          ),
                          child: Image.asset(
                            'lib/Assets/Images/logo.png',
                            height: 250,
                            width: 200,
                          ),
                        ),

                        SizedBox(height: !zoomheight ? 30 : 0),

                        // bottom container
                        Container(
                          padding: const EdgeInsets.only(top: 40),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // tabs
                                SizedBox(
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 60.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                            onTap: SignupScreen(),
                                            color: Colors.white,
                                            buttonText: "Sign up",
                                            textColor: isLogin
                                                ? AppColors.Text300
                                                : AppColors.Main400,
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomButton(
                                            onTap: LoginScreen(),
                                            color: Colors.white,
                                            buttonText: "Login",
                                            textColor: isLogin
                                                ? AppColors.Main400
                                                : AppColors.Text300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // form content
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: child!,
                                ),
                                
                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
