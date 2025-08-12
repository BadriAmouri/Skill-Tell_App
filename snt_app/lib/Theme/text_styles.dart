import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';


class TextStyles {

  static const TopNavBarTitle = TextStyle(
    fontFamily: AppFonts.primaryFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColors.Neutral400,
  );

  static const Subtitle = TextStyle(
    fontFamily: AppFonts.primaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.Neutral400,
  );

  static const EventTitle = TextStyle(
    fontFamily: AppFonts.primaryFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.Neutral600,
  );

  static const EventDesc = TextStyle(
    fontFamily: AppFonts.primaryFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.Neutral400,
  );

  static const DateAndLocation = TextStyle(
    fontFamily: AppFonts.primaryFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.Neutral400,
  );
}