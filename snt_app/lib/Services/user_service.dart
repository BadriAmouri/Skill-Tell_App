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

    // Map JSON to UserModel
    final userModel = UserModel.fromJson(response);
    return userModel;
  }


}
