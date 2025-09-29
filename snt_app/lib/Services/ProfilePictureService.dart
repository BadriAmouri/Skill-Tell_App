// lib/Services/profile_picture_service.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePictureService {
  // A unique key to store the profile picture in SharedPreferences
  static const String _profilePictureKey = 'user_profile_picture';

  /// Saves the user's profile picture to SharedPreferences.
  ///
  /// The image bytes are encoded to a Base64 string for storage.
  Future<void> saveProfilePicture(Uint8List imageBytes) async {
    final prefs = await SharedPreferences.getInstance();
    final String base64Image = base64Encode(imageBytes);
    await prefs.setString(_profilePictureKey, base64Image);
  }

  /// Loads the user's profile picture from SharedPreferences.
  ///
  /// Returns the image as [Uint8List], or `null` if no picture is saved.
  Future<Uint8List?> loadProfilePicture() async {
    final prefs = await SharedPreferences.getInstance();
    final String? base64Image = prefs.getString(_profilePictureKey);

    if (base64Image != null) {
      // If data exists, decode it from Base64 back to bytes
      return base64Decode(base64Image);
    }
    // Return null if no profile picture has been saved
    return null;
  }

  /// Removes the user's profile picture from SharedPreferences.
  Future<void> clearProfilePicture() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_profilePictureKey);
  }
}