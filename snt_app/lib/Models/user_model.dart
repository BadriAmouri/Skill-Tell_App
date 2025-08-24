class UserModel {
  final String userId;
  final String username;
  final String email;
  final String password;
  final List<String> skills;
  final List<String> interests;
  final String role;
  final String? pfp;
  final String dateOfBirth;
  final String phoneNumber;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.skills,
    required this.interests,
    required this.role,
    this.pfp,
    required this.dateOfBirth,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      skills: List<String>.from(json['skills']),
      interests: List<String>.from(json['interests']),
      role: json['role'],
      pfp: json['pfp'] == "" ? null : json['pfp'],
      dateOfBirth: json['date_of_birth'],
      phoneNumber: json['phone_number'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'password': password,
      'skills': skills,
      'interests': interests,
      'role': role,
      'pfp': pfp ?? "",
      'date_of_birth': dateOfBirth,
      'phone_number': phoneNumber,
    };
  }
}
