import 'package:flutter/material.dart';
import 'package:snt_app/Models/user_model.dart';
import 'package:snt_app/Services/department_service.dart';
import 'package:snt_app/Services/user_service.dart';
import 'package:snt_app/Widgets/HomePage/Departments/DepartmentMember/department_member_card.dart';

class DepartmentMembersList extends StatefulWidget {
  final String departmentName;

  const DepartmentMembersList({Key? key, required this.departmentName})
      : super(key: key);

  @override
  State<DepartmentMembersList> createState() => _DepartmentMembersListState();
}

class _DepartmentMembersListState extends State<DepartmentMembersList> {
  final departmentService = DepartmentService();
  late Future<List<UserModel>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = departmentService.getUsersByDepartment(widget.departmentName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      future: _futureUsers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No members found."));
        }

        final users = snapshot.data!;

        users.sort((a, b) {
          int getPriority(String role) {
            switch (role.toLowerCase()) {
              case 'manager':
                return 0;
              case 'co-manager':
                return 1;
              case 'member':
                return 2;
              default:
                return 3; // fallback for unknown roles
            }
          }

          return getPriority(a.role).compareTo(getPriority(b.role));
        });

        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: DepartmentMemberCard(user: users[index]),
              );
            },
          ),
        );
      },
    );
  }
}
