import 'package:flutter/material.dart';
import 'package:snt_app/Widgets/General/button.dart';
import 'package:snt_app/Widgets/SignUp&LogIn/custom_scaffold.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:snt_app/Screens/login/new_password_screen.dart';
import 'package:flutter/services.dart';

class VerifyCodeScreen extends StatefulWidget{
  const VerifyCodeScreen({super.key});
  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}
class _VerifyCodeScreenState extends State<VerifyCodeScreen>{
  late Timer _timer;
  int _secondsRemaining = 59;
  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController());
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); 
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
                  const SizedBox(width: 50,),
                  Text(
                    "Enter the code",
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
              Text(
                "00:${_secondsRemaining.toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.Main300,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
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
                    onTap: () {
                      _timer.cancel();
                      setState(() {
                        _secondsRemaining = 59;
                      });
                      _startTimer();
                      for (final controller in _controllers) {
                        controller.clear();
                      }
                    },
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
              const SizedBox(height: 50,),
              Button(
                onTap: () {
                  bool allFilled = _controllers.every((controller) => controller.text.isNotEmpty);
                  bool timeRemaining = _secondsRemaining > 0; 

                  if (allFilled && timeRemaining) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (e) => NewPasswordScreen()),
                    );
                  } else {
                    String errorMessage = !allFilled
                        ? 'Please fill in all the code boxes'
                        : 'The verification code has expired';

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                        backgroundColor: AppColors.Error100,
                      ),
                    );
                  }
                },
                buttonText: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}