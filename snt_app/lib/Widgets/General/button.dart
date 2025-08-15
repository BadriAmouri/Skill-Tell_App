import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';

class Button extends StatelessWidget {
  final VoidCallback? onTap; 
  final String buttonText;

  const Button({
    super.key,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap!,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 380,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.Main400,
            borderRadius: const BorderRadius.all(Radius.circular(22)),
          ),
          child: Center(
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.Main100,
              ),
            ),
          ),
        ),
      )
    );
  }
}
