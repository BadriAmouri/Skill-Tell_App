import 'package:supabase_flutter/supabase_flutter.dart';


class AuthService {
  
  final supabase = Supabase.instance.client;

  // send otp
  Future<void> resendEmailOtp(String email) async {
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

  Future<bool> requestEmailOtp(String email) async {
    try {
      // 1. Check if email already exists in your "users" table
      final userCheck = await supabase.from('users').select().eq('email', email);
      if (userCheck.isNotEmpty) {
        print("Email already in use.");
        return false;
      }

      // 2. Start fresh sign-in with OTP
      await supabase.auth.signInWithOtp(
        email: email,
        shouldCreateUser: true,
      );
      print("OTP sent to $email");
      return true;

    } catch (e) {
      print("Error in requestEmailOtp: $e");
      return false;
    }
  }



  // verify otp
  Future<bool> verifyEmailOtpForSignup(String email, String otp) async {
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
        'email': user.email,
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

  // verifying that the user exists
  Future<bool> doesUserExist(String email) async {
    final response = await supabase
        .from('users') // your public profile table (if you sync users here)
        .select('user_id')
        .eq('email', email)
        .maybeSingle(); // returns null if not found

    return response != null;
  }

  // sent otp code while the user exists
  Future<bool> sendEmailOtp(String email) async {
    if(! await doesUserExist(email)) {
      print("User does not exists!");
      return false;
    }
    try {
      await supabase.auth.resetPasswordForEmail(
        email,
      );
      print("OTP sent successfully");
      return true;
    } on AuthException catch (e) {
      print("Error: ${e.message}"); // will say "User not found"
      return false;
    } catch (e) {
      print("Unexpected error: $e");
      return false;
    }
  }

  Future<bool> verifyEmailOtp({
    required String email,
    required String otpCode,
  }) async {
    try {
      final response = await Supabase.instance.client.auth.verifyOTP(
        email: email,
        token: otpCode,
        type: OtpType.email,
      );

      // If successful, you'll get a Session back
      if (response.session != null) {
        print("OTP verified ✅ User logged in");
        return true;
      } else {
        print("OTP verification failed ❌");
        return false;
      }
    } on AuthException catch (e) {
      print("Invalid or expired OTP: ${e.message}");
      return false;
    } catch (e) {
      print("Unexpected error: $e");
      return false;
    }
  }


  Future<void> setNewPasswordAfterOtp(String newPassword) async {
    await Supabase.instance.client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }


}
