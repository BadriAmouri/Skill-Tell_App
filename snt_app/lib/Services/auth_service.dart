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
  Future<bool> verifyEmailOtp(String email, String otp) async {
    try {
      final res = await supabase.auth.verifyOTP(
        type: OtpType.email,
        email: email,
        token: otp,
      );

      final user = res.user;
      if (user == null) {
        print("OTP verification failed");
        return false;
      }
      

      print("OTP verified for user ${user.id}");
      return true;
    } catch (e) {
      print("Error verifying OTP: $e");
      return false;
    }
  }


  // ACTUALLY SIGNUP
  Future<void> setPasswordAndCreateProfile({
    required String password,
    required String username,
    required List<String> skills,
    required List<String> interests,
    required String departmentName, // only one department now
    required String dateOfBirth,
    String? phoneNumber,
    required String role,
  }) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception("No authenticated user");

      await supabase.auth.updateUser(UserAttributes(password: password));

      await supabase.from('users').upsert({
        'user_id': user.id,
        'username': username,
        'skills': skills,
        'interests': interests,
        'role': role,
        'pfp': null,
        'date_of_birth': dateOfBirth,
        'phone_number': phoneNumber,
      });


      await supabase.from('department_members').insert({
        'department_name': departmentName,
        'user_id': user.id,
      });

      print("Password set + Profile created + Department assigned!");
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
