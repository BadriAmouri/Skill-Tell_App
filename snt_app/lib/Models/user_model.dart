class UserModel {
  final String userId;
  final String username;
  final String email; // still comes from auth.users
  final List<String> skills;
  final List<String> interests;
  final String role;
  final String? pfp; // Nullable
  final String dateOfBirth;
  final String? phoneNumber; // Nullable
  final bool? isLoggedIn; // Nullable

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.skills,
    required this.interests,
    required this.role,
    this.pfp,
    required this.dateOfBirth,
    this.phoneNumber,
    this.isLoggedIn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String email) {
    return UserModel(
      userId: json['user_id'] as String,
      username: json['username'] as String,
      email: email, // we inject it from auth.users
      skills: json['skills'] != null
          ? List<String>.from(json['skills'])
          : <String>[],
      interests: json['interests'] != null
          ? List<String>.from(json['interests'])
          : <String>[],
      role: json['role'] as String,
      pfp: json['pfp'] as String?, 
      dateOfBirth: json['date_of_birth'] as String,
      phoneNumber: json['phone_number'] as String?,
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'skills': skills,
      'interests': interests,
      'role': role,
      'pfp': pfp,
      'date_of_birth': dateOfBirth,
      'phone_number': phoneNumber,
      'isLoggedIn': isLoggedIn,
    };
  }
}
