import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snt_app/Screens/Home/home_screen.dart';
import 'package:snt_app/Screens/login/forgot_password_screen.dart';
import 'package:snt_app/Services/auth_service.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snt_app/Widgets/General/button.dart';
import 'package:snt_app/Widgets/General/input.dart';
import 'package:snt_app/Widgets/General/loading.dart';
import 'package:snt_app/Widgets/SignUp&LogIn/custom_scaffold.dart';
import 'package:snt_app/utils/regex_functions.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
  bool rememberMe = false;
  bool _obscurePassword = true;
  bool _showEmailError = false;
  bool _showPasswordError = false;
  final TextEditingController myEmailController = TextEditingController();
  final TextEditingController myPasswordController = TextEditingController();

  final auth_service = AuthService();

  @override
  void dispose(){
    myEmailController.dispose();
    myPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome back !",
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
                  "Glad to see you again dearest skillnteller! Please enter your log in information.",
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
                        obscureText: _obscurePassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                            ),
                            child: _obscurePassword
                              ? SvgPicture.asset('lib/Assets/Icons/hide_.svg', height: 20, width: 20,) 
                              : SvgPicture.asset('lib/Assets/Icons/show_.svg', height: 18, width: 18,), 
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (_showPasswordError)
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
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Checkbox(
                          value: rememberMe, 
                          onChanged: (bool? newValue ){
                            setState((){
                              rememberMe = newValue ?? false;
                            });
                          },
                          activeColor: AppColors.Main400,
                          side: BorderSide(color: AppColors.Text300, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.8),
                          ),
                        );
                      },
                    ),
                    Text(
                      "Remember me",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: AppColors.Text400,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot password ?",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: AppColors.Text400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(
                  left: 29,
                  right: 29,
                  bottom: 30
                ),
                child: Button(
                  onTap: _login,
                  buttonText: 'Login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
  setState(() {
    _showEmailError = myEmailController.text.isEmpty || !isValidEmail(myEmailController.text.trim());
    _showPasswordError = myPasswordController.text.length < 8;
  });

  if (!_showEmailError && !_showPasswordError) {
    showLoadingDialog(context);

    try {
      final response = await auth_service.signInWithEmailPassword(
        myEmailController.text.trim(),
        myPasswordController.text.trim(),
      );

      hideLoadingDialog(context);

      if (response.user != null) {
        // Success → Go to home
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        //  Failed → Show error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid email or password")),
        );
      }
    } catch (e) {
      hideLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login error: Please verify your info..")),
      );
    }
  }
}


}
  
