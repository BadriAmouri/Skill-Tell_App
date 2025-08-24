import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/General/button.dart';
import 'package:snt_app/Widgets/General/input.dart';
import 'package:snt_app/Widgets/SignUp&LogIn/custom_scaffold.dart';
import 'package:snt_app/Screens/signup/your_info.dart';

class CreatePassword extends StatefulWidget{
  final String email;
  const CreatePassword({super.key, required this.email});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}
class _CreatePasswordState extends State<CreatePassword>{
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
      isLogin: false,
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
                    "Create password",
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
                      prefixIcon: 'lib/Assets/Icons/profile_.svg', 
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
                            ? SvgPicture.asset('lib/Assets/Icons/hide_.svg', height: 20, width: 20,) 
                            : SvgPicture.asset('lib/Assets/Icons/show_.svg', height: 18, width: 18,), 
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
                      prefixIcon: 'lib/Assets/Icons/profile_.svg', 
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
                            ? SvgPicture.asset('lib/Assets/Icons/hide_.svg', height: 20, width: 20,) 
                            : SvgPicture.asset('lib/Assets/Icons/show_.svg', height: 18, width: 18,), 
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
              const SizedBox(height: 50,),
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

  void _continue() {
    setState(() {
      _passwordTooShort = myPasswordController.text.length < 8;
      _passwordsDoNotMatch = myPasswordController.text != confirmPasswordController.text;
    });

    if (!_passwordTooShort && !_passwordsDoNotMatch) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (e) => YourInfo(password: myPasswordController.text, email: widget.email)
        ),
      );
    }
  }
}