import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:snt_app/Models/department_model.dart';

class DepartmentService {
  Future<List<DepartmentModel>> fetchDepartments() async {
    await Future.delayed(const Duration(seconds: 2));

    final String response =
        await rootBundle.loadString('lib/Assets/Data/departments.json');
    final List<dynamic> data = json.decode(response);
    return data.map((e) => DepartmentModel.fromJson(e)).toList();
  }
}
