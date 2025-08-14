import 'package:flutter/material.dart';
import 'package:snt_app/widgets/custom_scaffold.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snt_app/widgets/button.dart';
import 'package:snt_app/Screens/home_screen.dart';
import 'package:snt_app/widgets/input.dart';

class NewPasswordScreen extends StatefulWidget{
  const NewPasswordScreen({super.key});
  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}
class _NewPasswordScreenState extends State<NewPasswordScreen>{
  bool _passwordTooShort = false;
  bool _passwordsDoNotMatch = false;
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController myPasswordController = TextEditingController();
  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;
  @override
  void dispose(){
    confirmPasswordController.dispose();
    myPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          // color: Colors.red,
          padding: const EdgeInsets.only(
            top: 10,
            left: 29,
            right: 29,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'lib/Assets/icons/arrowLeft_.svg', 
                      width: 25,
                      height: 25,
                    ),
                  ),
                  const SizedBox(width: 26,),
                  Text(
                    "Create new password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: AppColors.Text500,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Text(
                  "Lorem ipsum dolor sit amet consectetur. Tellus leo vitae aliquet vel tortor. Interdum tempus Interdum tempus",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColors.Text400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: AppColors.Text400,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Input(
                      prefixIcon: 'lib/Assets/icons/profile_.svg', 
                      placeholder: 'Password',
                      controller: myPasswordController,
                      obscureText: _obscurePassword1,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword1 = !_obscurePassword1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: _obscurePassword1
                            ? SvgPicture.asset('lib/Assets/icons/hide_.svg', height: 20, width: 20,) 
                            : SvgPicture.asset('lib/Assets/icons/show_.svg', height: 18, width: 18,), 
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (_passwordTooShort)
                      Text(
                        "Password must be at least 8 characters",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: AppColors.Error100,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8,),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Confirm Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: AppColors.Text400,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Input(
                      prefixIcon: 'lib/Assets/icons/profile_.svg', 
                      placeholder: 'Confirm Password',
                      controller: confirmPasswordController,
                      obscureText: _obscurePassword2,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword2 = !_obscurePassword2;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: _obscurePassword2
                            ? SvgPicture.asset('lib/Assets/icons/hide_.svg', height: 20, width: 20,) 
                            : SvgPicture.asset('lib/Assets/icons/show_.svg', height: 18, width: 18,), 
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (_passwordsDoNotMatch)
                      Text(
                        "Passwords must match",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: AppColors.Error100,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Button(
                onTap: () {
                  setState(() {
                    _passwordTooShort = myPasswordController.text.length < 8;
                    _passwordsDoNotMatch = myPasswordController.text != confirmPasswordController.text;
                  });

                  if (!_passwordTooShort && !_passwordsDoNotMatch) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  }
                },
                buttonText: "Login",
              ),
            ],
          ),
        ),
      ),
    );
  }
}