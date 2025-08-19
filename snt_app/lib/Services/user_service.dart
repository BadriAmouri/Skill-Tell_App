import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:snt_app/Models/user_model.dart';

class UserService {
  Future<List<UserModel>> fetchUsers() async {
    await Future.delayed(const Duration(seconds: 2));

    final String response = await rootBundle.loadString('lib/Assets/Data/users.json');
    final List<dynamic> data = json.decode(response);
    return data.map((e) => UserModel.fromJson(e)).toList();
  }


  Future<List<UserModel>> fetchUsersByDepartment(String department_name) async {
    await Future.delayed(const Duration(seconds: 2));

    final String response = await rootBundle.loadString('lib/Assets/Data/users.json');
    final List<dynamic> data = json.decode(response);

    // Convert JSON to List<UserModel>
    List<UserModel> allUsers = data.map((e) => UserModel.fromJson(e)).toList();

    // Filter by department
    List<UserModel> filteredUsers = allUsers
        .where((user) => user.department == department_name)
        .toList();

    return filteredUsers;
  }

}
