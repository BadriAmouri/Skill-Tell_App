import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';
import 'package:snt_app/Widgets/General/custom_app_bar.dart';
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
      appBar: CustomAppBar(title: 'Home'),
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.only(left: 24, bottom: 2, top: 32),
                child: UpcomingEventsSection(title: "Upcoming Events"),
              ),

              Padding(
                padding: EdgeInsets.only(top: 10),
                child: PreviousEventsSection(title: "Previous Events"),
              ),

              Padding(
                padding: EdgeInsets.only(top: 32),
                child: DepartmentsSection(title: "Our Departments"),
              ),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
