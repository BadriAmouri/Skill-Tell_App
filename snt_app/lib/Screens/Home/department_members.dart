import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';
import 'package:snt_app/Widgets/General/input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snt_app/Widgets/HomePage/Departments/DepartmentMember/department_members_list.dart';
// import 'package:snt_app/Widgets/HomePage/Departments/DepartmentMember/department_members_list.dart';

class DepartmentMembers extends StatelessWidget {
  final int _selectedIndex = -1;
  final String department_name;

  DepartmentMembers({Key? key, required this.department_name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      appBar: AppBar(
        leading: IconButton(
        icon: SvgPicture.asset(
          'lib/Assets/Icons/arrowLeft_.svg',
          width: 24,
          height: 24,
          color: AppColors.Text400, 
        ),
        onPressed: () => Navigator.pop(context), 
      ),
        title: Text(
          department_name,
          style: const TextStyle(
            fontFamily: AppFonts.primaryFontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.Text400,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.White,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Input(
                  prefixIcon: 'lib/Assets/Icons/Search.svg',
                  placeholder: "Search",
                  height: 48,
                ),
                DepartmentMembersList(departmentName: department_name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
