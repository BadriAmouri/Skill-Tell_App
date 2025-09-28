import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget? onTap;
  final Color? color;
  final String? buttonText;
  final Color? textColor;
  final bool pushReplacement;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.buttonText,
    required this.textColor,
    this.pushReplacement = false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(pushReplacement) {
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(
              builder: (e) => onTap!,
            ),
          );
        }
        else {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (e) => onTap!,
            ),
          );
        }
        
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 6,
          bottom: 8,
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
          color: color!,
          border: Border(
            bottom: BorderSide(
              color: textColor!,
              width: 2,
            ),
          ),
        ),
        child: Text(
          buttonText!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: textColor!,
          )
        ),
      ),
    );
      
  }
}
