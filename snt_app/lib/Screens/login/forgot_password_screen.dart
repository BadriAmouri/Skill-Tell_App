import 'package:flutter/material.dart';
import 'package:snt_app/Services/auth_service.dart';
import 'package:snt_app/Widgets/General/button.dart';
import 'package:snt_app/Widgets/General/input.dart';
import 'package:snt_app/Widgets/SignUp&LogIn/custom_scaffold.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snt_app/Screens/login/verify_code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget{
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>{
  final TextEditingController myEmailController = TextEditingController();
  bool _showEmailError = false;

  final authService = AuthService();
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'lib/Assets/Icons/arrowLeft_.svg', 
                      width: 25,
                      height: 25,
                    ),
                  ),
                  Text(
                    "Forgot password ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: AppColors.Text500,
                    ),
                  ),
                  const SizedBox(width: 25,),
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
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: AppColors.Text400,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Input(
                      prefixIcon: 'lib/Assets/Icons/profile_.svg', 
                      placeholder: 'Email',
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
                onTap: _continue,
                buttonText: 'Continue',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _continue() async{
    setState(() {
      _showEmailError = myEmailController.text.isEmpty && !isValidEmail(myEmailController.text);
    });

    if (!_showEmailError) {
      showLoadingDialog(context);
      await authService.sendEmailOtp(myEmailController.text);
      hideLoadingDialog(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (e) => VerifyCodeScreen(email: myEmailController.text)),
      );
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return emailRegex.hasMatch(email);
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(); 
  }
}