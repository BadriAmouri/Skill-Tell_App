import 'package:flutter/material.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/Card/card.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        title: const Text(
          'Profile Card',
          style: TextStyles.TopNavBarTitle,
        ),
        centerTitle: true,
        backgroundColor: AppColors.White,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex,),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: RotatedBox(
              quarterTurns: -1,
              child: MemberCard()
            ),
          ),
        ),
      )
    );
  }
}