


 import 'package:flutter/material.dart';
import 'package:snt_app/Constants/Departments.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Widgets/HomePage/Departments/departments_scrolling_view.dart';

class DepartmentsSection extends StatelessWidget {
  final String title;
  
   const DepartmentsSection({
     super.key,
     required this.title,
   });
 
   @override
   Widget build(BuildContext context) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       spacing: 12,
       children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
           child: Text(
             title,
             style: TextStyles.Subtitle
           ),
         ),
        DepartmentsScrollingView(departments: DepartmentsData.departments),
       ],
     );
   }
 }