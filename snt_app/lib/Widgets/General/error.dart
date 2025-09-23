import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';

void showErrorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.Error100,
      ),
    );
}