import 'package:flutter/material.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';

class EmptyScreen extends StatelessWidget {

  final int selectedIndex;
  const EmptyScreen({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        title: Text(
          "$selectedIndex",
          style: TextStyles.TopNavBarTitle,
        ),
        centerTitle: true,
        backgroundColor: AppColors.White,
        elevation: 0,
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: selectedIndex,),
      body: const Center(
        child: Text(
          'EMPTY Screen!',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: AppColors.Main600,
          ),
        ),
      ),
    );
  }
}