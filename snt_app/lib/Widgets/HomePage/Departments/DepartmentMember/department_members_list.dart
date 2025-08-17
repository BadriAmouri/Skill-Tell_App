import 'package:flutter/material.dart';
import 'package:snt_app/Models/user_model.dart';
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
  final UserService _userService = UserService();
  late Future<List<UserModel>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = _userService.fetchUsersByDepartment(widget.departmentName);
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

        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return DepartmentMemberCard(user: users[index]);
            },
          ),
        );
      },
    );
  }
}
