import 'package:flutter/material.dart';
import 'package:snt_app/Screens/signup/otpcode_verification.dart';
import 'package:snt_app/Services/auth_service.dart';
import 'package:snt_app/Theme/spacing_consts.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/General/button.dart';
import 'package:snt_app/Widgets/General/input.dart';
import 'package:snt_app/Widgets/General/loading.dart';
import 'package:snt_app/Widgets/SignUp&LogIn/custom_scaffold.dart';
import 'package:snt_app/utils/regex_functions.dart';
import 'package:snt_app/Models/user_model.dart';
import 'package:snt_app/Services/shared_prefs_service.dart';

class SignupScreen extends StatefulWidget{
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen>{

  bool agree = false;
  bool _showEmailError = false;
  bool _showCodeError = false;
  bool _usedEmail = false;
  final TextEditingController myEmailController = TextEditingController();
  final TextEditingController myCodeController = TextEditingController();

  final auth_service = AuthService();

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
            top: 0,
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
                  "We can't wait for you to be a part of our team!! Join us with your Email now!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColors.Text400,
                  ),
                ),
              ),
              const SizedBox(height: SignUpLogInSpacingConsts.UnderDesc),
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
                      if (_usedEmail)
                        Text(
                          "This Email is already used.",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: AppColors.Error100,
                          ),
                        )
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
              Padding(
                padding: const EdgeInsets.only(
                  left: 29,
                  right: 29,
                  bottom: 15,
                  top: SignUpLogInSpacingConsts.ContinueBtnTopPadding,
                ),
                child: Button(
                  onTap: () {
                    _continue();
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


  void _continue() async {
    final email = myEmailController.text.trim();

    // run async OTP request first
    showLoadingDialog(context);
    final otpResult = await auth_service.requestEmailOtp(email);
    hideLoadingDialog(context);

    setState(() {
      _showEmailError = email.isEmpty || !isValidEmail(email);
      _showCodeError = myCodeController.text.isEmpty;
      _usedEmail = !otpResult;
    });

    if (!_showEmailError && !_showCodeError && agree && !_usedEmail) {
      // Create a new UserModel with initial values
      final newUser = UserModel(
        userId: DateTime.now().millisecondsSinceEpoch.toString(), // This should be replaced with actual user ID after auth
        username: email.split('@')[0], // Initial username from email
        email: email,
        skills: [], // Empty initially, user can add later
        interests: [], // Empty initially, user can add later
        role: 'member', // Default role
        dateOfBirth: '', // Will be set in next screens
        phoneNumber: null,
        isLoggedIn: false,
      );

      // Save the user data
      await SharedPrefsService.saveUser(newUser);

      // Navigate to OTP verification
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPCodeVerification(email: email , userModel : newUser),
        ),
      );
    }

    if (!agree && !_showEmailError && !_showCodeError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You must agree on the terms and conditions to proceed",
            style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
          ),
          backgroundColor: AppColors.Error100,
        ),
      );
    }
  }


}