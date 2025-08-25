import 'package:flutter/material.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';
import 'package:snt_app/Widgets/General/input.dart';
import 'package:snt_app/Widgets/HomePage/Departments/DepartmentMember/department_members_list.dart';
// import 'package:snt_app/Widgets/HomePage/Departments/DepartmentMember/department_members_list.dart';


class DepartmentMembers extends StatelessWidget{

  final int _selectedIndex = -1;
  final String department_name; 

  DepartmentMembers({Key? key, required this.department_name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        title: Text(
          department_name,
          style: TextStyles.TopNavBarTitle,
        ),
        centerTitle: true,
        backgroundColor: AppColors.White,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex,),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          child: Center(
            child: Column(
              spacing: 22,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Input(prefixIcon: 'lib/Assets/Icons/Search.svg', placeholder: "Search", height: 48),
                DepartmentMembersList(departmentName: department_name)
              ],
            ),
          )
        ),
      )
    );
  }
}

