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
}
