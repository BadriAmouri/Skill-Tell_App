import 'package:flutter/material.dart';
import 'package:snt_app/Models/department_model.dart';
import 'package:snt_app/Widgets/HomePage/Departments/department_card.dart';

class DepartmentsScrollingView extends StatelessWidget {
  final List<DepartmentModel> departments;

  const DepartmentsScrollingView({Key? key, required this.departments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: departments.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          return DepartmentCard(department: departments[index]);
        },
      ),
    );
  }
}
