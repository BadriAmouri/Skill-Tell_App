import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;
  final Color backgroundColor;
  final Color textColor;
  final Widget? rightIcon;
  final VoidCallback? onRightIconPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.hasBackButton = false,
    this.backgroundColor = AppColors.White,
    this.textColor = AppColors.Text500,
    this.rightIcon,
    this.onRightIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: hasBackButton 
        ? IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.Text500),
            onPressed: () => Navigator.pop(context),
          )
        : null,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: AppFonts.primaryFontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      centerTitle: true,
      backgroundColor: backgroundColor,
      elevation: 0,
      actions: rightIcon != null
        ? [
            IconButton(
              icon: rightIcon!,
              onPressed: onRightIconPressed,
            ),
          ]
        : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}