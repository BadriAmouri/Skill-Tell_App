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
    print(response);
    final userModel = UserModel.fromJson(response, currentUser.email ?? '');
    return userModel;
  }



}
