import 'package:supabase_flutter/supabase_flutter.dart';


class AuthService {
  
  final supabase = Supabase.instance.client;

  // send otp
  Future<void> requestEmailOtp(String email) async {
    try {
      await supabase.auth.signInWithOtp(
        email: email,
        shouldCreateUser: true, // create temp user if doesn't exist
      );
      print("OTP sent to $email");
    } catch (e) {
      print("Error sending OTP: $e");
      rethrow;
    }
  }


  // verify otp
  Future<User?> verifyEmailOtp(String email, String otp) async {
    try {
      final res = await supabase.auth.verifyOTP(
        type: OtpType.email,
        email: email,
        token: otp,
      );

      final user = res.user;
      if (user == null) throw Exception("OTP verification failed");

      print("OTP verified for user ${user.id}");
      return user;
    } catch (e) {
      print("Error verifying OTP: $e");
      rethrow;
    }
  }


  // ACTUALLY SIGNUP
  Future<void> setPasswordAndCreateProfile({
    required String password,
    required String username,
    required List<String> skills,
    required List<String> interests,
    required List<String> departmentNames,
    String role = 'member',
  }) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception("No authenticated user");

      // 1) Set password
      await supabase.auth.updateUser(UserAttributes(password: password));

      // 2) Create profile
      final profile = {
        'user_id': user.id,
        'username': username,
        'email': user.email,
        'skills': skills,
        'interests': interests,
        'role': role,
        'pfp': null,
      };

      await supabase.from('users').upsert(profile);

      // 3) Add to departments
      if (departmentNames.isNotEmpty) {
        final deptRows = departmentNames.map((deptName) {
          return {
            'department_name': deptName,
            'user_id': user.id,
          };
        }).toList();

        await supabase.from('department_members').insert(deptRows);
      }

      print("Password set + Profile + Departments created!");
    } catch (e) {
      print("Error setting password or saving profile: $e");
      rethrow;
    }
  }



  // sign in
  Future<AuthResponse> signInWithEmailPassword(String email, String password) async{
    return await supabase.auth.signInWithPassword(password: password, email: email);
  }


  // sign out
  Future<void> signOut() async{
    return await supabase.auth.signOut();
  }

}
