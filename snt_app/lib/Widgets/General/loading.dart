import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.Main500,),
      );
    },
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop(); 
}