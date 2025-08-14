import 'package:flutter/material.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';
import 'package:snt_app/Widgets/HomePage/Departments/departments_section.dart';
import 'package:snt_app/Widgets/HomePage/PreviousEvents/previous_events_section.dart';
import 'package:snt_app/Widgets/HomePage/UpcomingEvents/upcoming_events_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = -1;

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
      bottomNavigationBar: CustomBottomNavBar(currentIndex: _selectedIndex,),
      body: SafeArea(
        child: SingleChildScrollView(
          // gotta fix the padding
          child: Column(
            // fix the spacing
            children: [

              // upcoming events
              Padding(
                padding: EdgeInsets.only(left: 24, bottom: 2, top: 32),
                child: UpcomingEventsSection(title: "Upcoming Events")
              ),

              // prev events
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: PreviousEventsSection(title: "Previous Events")
              ),

              // depatments
              Padding(
                padding: EdgeInsets.only(top: 32),
                child: DepartmentsSection(title: "Our Departments")
              ),

              SizedBox(height: 32,)
            ],
          ),
        ),
      )
    );
  }
}

