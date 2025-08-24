import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snt_app/Theme/theme.dart';

class Input extends StatelessWidget {
  final String prefixIcon;
  final String placeholder;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final double height;
  final TextInputType textInputType;

  const Input({
    super.key,
    required this.prefixIcon,
    required this.placeholder,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.height = 44,
    this.textInputType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: AppColors.Text400,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 7,
            ),
            child: SvgPicture.asset(
              prefixIcon,
              width: 24,
              height: 24,
              color: AppColors.Text400,
            )
          ),
          suffixIcon: suffixIcon,
          hintText: placeholder,
          hintStyle: TextStyle(
            color: AppColors.Text300,
            fontSize: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: AppColors.Text300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: AppColors.Text300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: AppColors.Text300),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        ),
      ),
    );
  }
}
