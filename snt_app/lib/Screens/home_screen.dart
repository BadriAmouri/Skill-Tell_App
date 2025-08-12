import 'package:flutter/material.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';
import 'package:snt_app/Widgets/HomePage/UpcomingEvents/upcoming_events_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyles.TopNavBarTitle,
        ),
        centerTitle: true,
        backgroundColor: AppColors.White,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex,),
      body: SafeArea(
        child: SingleChildScrollView(
          // gotta fix the padding
          child: Column(
            // fix the spacing
            children: [

              // upcoming events
              Padding(
                padding: EdgeInsets.only(left: 24, bottom: 32),
                child: UpcomingEventsSection(title: "Upcoming Events")),
              

              // prev events

              // depatments
            ],
          ),
        ),
      )
    );
  }
}

