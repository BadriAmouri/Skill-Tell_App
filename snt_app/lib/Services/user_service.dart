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
}
