import 'package:snt_app/Models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:snt_app/Models/department_model.dart';

class DepartmentService {
  final supabase = Supabase.instance.client;

  Future<List<DepartmentModel>> fetchDepartments() async {
    try {
      final response = await supabase.from('departments').select();

      return (response as List<dynamic>)
          .map((e) => DepartmentModel.fromJson(e))
          .toList();
    } catch (e) {
      print("Error fetching departments: $e");
      return [];
    }
  }

  Future<List<UserModel>> getUsersByDepartment(String departmentName) async {
    // Step 1: Get all user_ids in this department
    final membersResponse = await supabase
        .from('department_members')
        .select('user_id')
        .eq('department_name', departmentName);

    if (membersResponse.isEmpty) return [];

    final userIds = membersResponse.map((m) => m['user_id'] as String).toList();

    // Step 2: Get user profiles (including email) from "users" table
    final profilesResponse = await supabase
        .from('users')
        .select()
        .inFilter('user_id', userIds);

    // Step 3: Map into UserModel list directly (since email is now included)
    final users = profilesResponse.map<UserModel>((json) {
      return UserModel.fromJson(json, json['email'] as String);
    }).toList();

    return users;
  }


}
