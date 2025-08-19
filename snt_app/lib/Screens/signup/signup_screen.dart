import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Screens/signup/create_password.dart';
import 'package:snt_app/Widgets/General/button.dart';
import 'package:snt_app/Widgets/General/input.dart';
import 'package:snt_app/Widgets/SignUp&LogIn/custom_scaffold.dart';

class SignupScreen extends StatefulWidget{
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen>{
  bool agree = false;
  bool _showEmailError = false;
  bool _showCodeError = false;
  final TextEditingController myEmailController = TextEditingController();
  final TextEditingController myCodeController = TextEditingController();
  @override
  void dispose(){
    myEmailController.dispose();
    myCodeController.dispose();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {
  return CustomScaffold(
    isLogin: false,
    child: Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "New member !",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: AppColors.Text500,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(
                left: 45,
                right: 45,
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
            Padding(
              padding: const EdgeInsets.only(
                left: 29,
                right: 29,
              ),
              child: Align(
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
                        "Please enter a correct email",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: AppColors.Error100,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(
                left: 29,
                right: 29,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Code",
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
                      placeholder: 'Code',
                      controller: myCodeController,
                    ),
                    const SizedBox(height: 4),
                    if (_showCodeError)
                      Text(
                        "Please enter a correct code",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: AppColors.Error100,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (bool? newValue) {
                      setState(() {
                        agree = newValue ?? false;
                      });
                    },
                    activeColor: AppColors.Main400,
                    side: BorderSide(color: AppColors.Text300, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.8),
                    ),
                  ),
                  Text(
                    "Agree with terms and conditions",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: AppColors.Text400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(
                left: 29,
                right: 29,
              ),
              child: Button(
                onTap: () {
                  setState(() {
                    _showEmailError = myEmailController.text.isEmpty;
                    _showCodeError = myCodeController.text.isEmpty;
                  });
        
                  if (!_showEmailError && !_showCodeError && agree) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreatePassword()),
                    );
                  }
                  if(!agree && !_showEmailError && !_showCodeError){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Text(
                            "You must agree on the terms and conditions to proceed",
                            style: TextStyle(
                              fontSize: 14, 
                              color: Colors.white, 
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        backgroundColor: AppColors.Error100,
                      ),
                    );
                  }
                },
                buttonText: 'Continue',
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}