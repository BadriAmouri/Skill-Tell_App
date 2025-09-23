import 'package:flutter/material.dart';
import 'package:snt_app/Models/department_model.dart';
import 'package:snt_app/Services/department_service.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Widgets/HomePage/Departments/departments_scrolling_view.dart';

class DepartmentsSection extends StatelessWidget {

  final String title;
  final DepartmentService departmentService = DepartmentService();
  

  DepartmentsSection({
    super.key,
    required this.title,
  });

  Future<List<DepartmentModel>> fetchDepartments() async {
    return departmentService.fetchDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,

      children: [
        // title
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            title,
            style: TextStyles.Subtitle
          ),
        ),

        FutureBuilder<List<DepartmentModel>>(
          future: fetchDepartments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                alignment: Alignment.center,
                height: 221,
                width: MediaQuery.of(context).size.width,
                child: CircularProgressIndicator()
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return DepartmentsScrollingView(departments: snapshot.data!);
            }
          }
        )
              
      ],
    );
  }
}