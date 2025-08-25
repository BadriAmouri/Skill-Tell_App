import 'package:snt_app/Models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final supabase = Supabase.instance.client;

  Future<UserModel?> getCurrentUser() async {
    final currentUser = supabase.auth.currentUser;

    if (currentUser == null) {
      return null; // no user is logged in
    }

    final response = await supabase
        .from('users')
        .select()
        .eq('user_id', currentUser.id)
        .single();

    // email comes from auth, other fields from public users
    final userModel = UserModel.fromJson(response, currentUser.email ?? '');
    return userModel;
  }

  // ----------------- USER UPDATES -----------------

  Future<void> updateUsername(String username) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('users').update({
      'username': username,
    }).eq('user_id', user.id);
  }

  Future<void> addSkill(String skill) async {
    final user = await getCurrentUser();
    if (user == null) return;

    final updatedSkills = [...user.skills, skill];
    await supabase.from('users').update({
      'skills': updatedSkills,
    }).eq('user_id', user.userId);
  }

  Future<void> removeSkill(String skill) async {
    final user = await getCurrentUser();
    if (user == null) return;

    final updatedSkills = user.skills.where((s) => s != skill).toList();
    await supabase.from('users').update({
      'skills': updatedSkills,
    }).eq('user_id', user.userId);
  }

  Future<void> replaceSkills(List<String> newSkills) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('users').update({
      'skills': newSkills,
    }).eq('user_id', user.id);
  }

  Future<void> addInterest(String interest) async {
    final user = await getCurrentUser();
    if (user == null) return;

    final updatedInterests = [...user.interests, interest];
    await supabase.from('users').update({
      'interests': updatedInterests,
    }).eq('user_id', user.userId);
  }

  Future<void> removeInterest(String interest) async {
    final user = await getCurrentUser();
    if (user == null) return;

    final updatedInterests =
        user.interests.where((i) => i != interest).toList();
    await supabase.from('users').update({
      'interests': updatedInterests,
    }).eq('user_id', user.userId);
  }

  Future<void> replaceInterests(List<String> newInterests) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('users').update({
      'interests': newInterests,
    }).eq('user_id', user.id);
  }

  Future<void> updateRole(String role) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('users').update({
      'role': role,
    }).eq('user_id', user.id);
  }

  Future<void> updateDateOfBirth(String dateOfBirth) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('users').update({
      'date_of_birth': dateOfBirth,
    }).eq('user_id', user.id);
  }

  Future<void> updatePhoneNumber(String? phoneNumber) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('users').update({
      'phone_number': phoneNumber,
    }).eq('user_id', user.id);
  }

  // ----------------- DEPARTMENT MEMBERS -----------------

  Future<void> addToDepartment(String departmentId) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('department_members').insert({
      'user_id': user.id,
      'department_name': departmentId,
    });
  }

  Future<void> removeFromDepartment(String departmentId) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase
        .from('department_members')
        .delete()
        .eq('user_id', user.id)
        .eq('department_name', departmentId);
  }

}
