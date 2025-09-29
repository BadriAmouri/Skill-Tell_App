import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snt_app/Models/user_model.dart';
import 'package:snt_app/Screens/signup/your_info.dart';
import 'package:snt_app/Theme/spacing_consts.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/General/button.dart';
import 'package:snt_app/Widgets/General/input.dart';
import 'package:snt_app/Widgets/SignUp&LogIn/custom_scaffold.dart';

class CreatePassword extends StatefulWidget {
  final String email;
  final UserModel? userModel;
  const CreatePassword({super.key, required this.email, this.userModel});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final TextEditingController myPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  bool _passwordTooShort = false;
  bool _passwordsDoNotMatch = false;
  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;

  @override
  void dispose() {
    myPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isLogin: false,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 29),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
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
                  const SizedBox(width: 25, height: 25),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Please enter and confirm your password.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColors.Text400,
                  ),
                ),
              ),
              const SizedBox(height: SignUpLogInSpacingConsts.UnderDesc),
              
              // Password Field
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
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
                        onTap: () => setState(() => _obscurePassword1 = !_obscurePassword1),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: _obscurePassword1
                              ? SvgPicture.asset('lib/Assets/Icons/hide_.svg', height: 20, width: 20)
                              : SvgPicture.asset('lib/Assets/Icons/show_.svg', height: 18, width: 18),
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
              const SizedBox(height: 8),

              // Confirm Password Field
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Confirm Password",
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
                        onTap: () => setState(() => _obscurePassword2 = !_obscurePassword2),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: _obscurePassword2
                              ? SvgPicture.asset('lib/Assets/Icons/hide_.svg', height: 20, width: 20)
                              : SvgPicture.asset('lib/Assets/Icons/show_.svg', height: 18, width: 18),
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
              const SizedBox(height: SignUpLogInSpacingConsts.ContinueBtnTopPadding),
              Button(
                onTap: _continue,
                buttonText: "Continue",
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

   // CORRECTED _continue METHOD
  void _continue() {
    setState(() {
      _passwordTooShort = myPasswordController.text.length < 8;
      _passwordsDoNotMatch = myPasswordController.text != confirmPasswordController.text;
    });

    if (!_passwordTooShort && !_passwordsDoNotMatch) {
      // Check if the userModel provided to this widget is not null.
      if (widget.userModel != null) {
        // If it's not null, pass it to the next screen.
        // The `!` operator here is safe because of the null check.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => YourInfoScreen(userModel: widget.userModel!),
          ),
        );
      } else {
        // As a fallback, if no userModel was provided, create a new one.
        final newUser = UserModel(
          email: widget.email,
          userId: '', // Default value
          username: '', // Will be filled in on the next screen
          skills: [],
          interests: [],
          role: '',
          dateOfBirth: '',
          isLoggedIn: false,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => YourInfoScreen(userModel: newUser,  password: myPasswordController.text),
          ),
        );
      }
    }
  }
}