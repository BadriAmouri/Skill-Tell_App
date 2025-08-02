import 'package:flutter/material.dart';
import 'package:snt_app/widgets/button.dart';
import 'package:snt_app/widgets/custom_scaffold.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snt_app/widgets/input.dart';
import 'package:snt_app/Screens/login/verify_code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget{
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>{
  final TextEditingController myEmailController = TextEditingController();
  bool _showEmailError = false;
  @override
  void dispose(){
    myEmailController.dispose();
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
                  const SizedBox(width: 40,),
                  Text(
                    "Forgot password ?",
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
                      "Email/Username",
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
                      placeholder: 'Email/Username',
                      controller: myEmailController,
                    ),
                    const SizedBox(height: 4),
                        if (_showEmailError)
                          Text(
                            "You must fill this input field",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: AppColors.Error100,
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(height: 100,),
              Button(
                onTap: () {
                  setState(() {
                    _showEmailError = myEmailController.text.isEmpty;
                  });

                  if (!_showEmailError) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (e) => VerifyCodeScreen()),
                    );
                  }
                },
                buttonText: 'Continue',
              ),
            ],
          ),
        ),
      ),
    );
  }
}