import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snt_app/Screens/login/new_password_screen.dart';
import 'package:snt_app/Services/auth_service.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/General/button.dart';
import 'package:snt_app/Widgets/SignUp&LogIn/custom_scaffold.dart';

class VerifyCodeScreen extends StatefulWidget {
  
  final String email;

  const VerifyCodeScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final auth_service = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
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
                    "Enter the code",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: AppColors.Text500,
                    ),
                  ),
                  SizedBox(width: 25, height: 25,)
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
              Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 52,
                    height: 52,
                    child: TextFormField(
                      controller: _controllers[index],
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      maxLength: 1,
                      onChanged: (value) {
                        setState(() {}); 
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        contentPadding: EdgeInsets.zero,
                        fillColor: _controllers[index].text.isNotEmpty
                            ? AppColors.Main200
                            : Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.Main500,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.Main500,
                            width: 2,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.Main500,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox( height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.Text400,
                    ),
                  ),
                  const SizedBox(width: 4,),
                  GestureDetector(
                    onTap: _resendCode,
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.Main300,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70,),
              Button(
                onTap: _continue,
                buttonText: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resendCode(){

    for (final controller in _controllers) {
      controller.clear();
    }

    auth_service.sendEmailOtp(widget.email);
  }


  void _continue() async{

    bool allFilled = _controllers.every((controller) => controller.text.isNotEmpty);

    if (allFilled) {

      String otpCode = _controllers.map((c) => c.text).join();
      
      showLoadingDialog(context);

      bool otpVerification = await auth_service.verifyEmailOtp(email: widget.email, otpCode: otpCode);

      hideLoadingDialog(context);

      if(otpVerification) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (e) => NewPasswordScreen()),
        );
      }
      else {
        showErrorMessage(context, "OTP verification failed or the code has expired");
      }
    } else {
      String errorMessage = !allFilled
          ? 'Please fill in all the code boxes'
          : 'The verification code has expired';
      showErrorMessage(context, errorMessage);
      
    }
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

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.Error100,
        ),
      );
  }
}