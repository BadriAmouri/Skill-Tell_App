import 'dart:typed_data';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:snt_app/Models/user_model.dart';
import 'package:snt_app/Services/ProfilePictureService.dart';
import 'package:snt_app/Services/shared_prefs_service.dart';
import 'package:snt_app/Theme/theme.dart';

class MemberCard extends StatefulWidget {
  const MemberCard({super.key});

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  // A single Future to fetch all necessary data at once.
  late Future<Map<String, dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future in initState to start fetching data.
    _dataFuture = _loadAllData();
  }

  /// Fetches both the user data and the profile picture concurrently.
  Future<Map<String, dynamic>> _loadAllData() async {
    // Use Future.wait to run both async calls in parallel for efficiency.
    final results = await Future.wait([
      SharedPrefsService.getUser(),
      ProfilePictureService().loadProfilePicture(),
    ]);
    // Return a map containing both results.
    return {
      'user': results[0] as UserModel?,
      'avatar': results[1] as Uint8List?,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        // 1. While data is loading, show a placeholder.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingCard();
        }

        // 2. If an error occurs during fetching.
        if (snapshot.hasError) {
          return _buildErrorCard('Failed to load profile data.');
        }

        // 3. If data is loaded, but is null or empty.
        if (!snapshot.hasData || snapshot.data == null) {
          return _buildErrorCard('No data found.');
        }

        // Extract the user and avatar from the snapshot data.
        final UserModel? user = snapshot.data!['user'];
        final Uint8List? avatarBytes = snapshot.data!['avatar'];

        // 4. If the user object is null, the user is not logged in or found.
        if (user == null) {
          return _buildErrorCard('User not found. Please log in.');
        }

        // 5. If everything is successful, build the actual FlipCard.
        return FlipCard(
          direction: FlipDirection.VERTICAL,
          front: _buildFrontCard(user, avatarBytes),
          back: _buildBackCard(),
        );
      },
    );
  }

  /// The front side of the card, displaying the user's information.
  Widget _buildFrontCard(UserModel user, Uint8List? avatarBytes) {
    return Container(
      height: 320,
      width: 550,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.11),
            blurRadius: 40.4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 25,
                left: 25,
                top: 5,
                bottom: 25,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("lib/Assets/Images/logo.png", width: 50),
                      Text(
                        "Member card",
                        style: TextStyle(
                          fontFamily: AppFonts.primaryFontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.purple[800],
                        ),
                      ),
                      QrImageView(
                        data:
                            user.userId, // Use user's unique ID for the QR code
                        version: QrVersions.auto,
                        size: 50,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      children: [
                        // Profile Image from ProfilePictureService
                        Container(
                          width: 200,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(217, 217, 217, 1),
                            borderRadius: BorderRadius.circular(8),
                            image:
                                avatarBytes != null
                                    ? DecorationImage(
                                      image: MemoryImage(avatarBytes),
                                      fit: BoxFit.cover,
                                    )
                                    : null,
                          ),
                          child:
                              avatarBytes == null
                                  ? const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.white,
                                  )
                                  : null,
                        ),
                        const SizedBox(width: 16),
                        // User Info from SharedPrefsService
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow("Name", user.username),
                              _buildAdaptiveEmailRow("Email", user.email),
                              _buildInfoRow(
                                "Phone number",
                                user.phoneNumber ?? 'N/A',
                              ),
                              _buildInfoRow(
                                "Date of birth",
                                user.dateOfBirth ?? 'N/A',
                              ),
                              _buildInfoRow("School", "ENSIAS"),
                              _buildInfoRow(
                                "Department",
                                user.department ?? 'N/A',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 24,
            width: 550,
            decoration: const BoxDecoration(
              color: Color(0xFF5A007B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage("lib/Assets/Images/Slide16_9-5.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ID NO: ${user.userId}",
                  style: const TextStyle(
                    fontFamily: AppFonts.primaryFontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.White,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The back side of the card.
  Widget _buildBackCard() {
    return Container(
      height: 320,
      width: 550,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("lib/Assets/Images/state=off.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// A placeholder widget to show while data is loading.
  Widget _buildLoadingCard() {
    return const SizedBox(
      height: 320,
      width: 550,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  /// A placeholder widget to show when an error occurs.
  Widget _buildErrorCard(String message) {
    return Container(
      height: 320,
      width: 550,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.redAccent),
      ),
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.redAccent, fontSize: 16),
        ),
      ),
    );
  }

  /// Helper to build a row of information (label and value).
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: AppFonts.primaryFontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.Neutral400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: AppFonts.primaryFontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.Neutral300,
          ),
        ),
      ],
    );
  }

  /// Special builder for email that adapts font size based on text length
  Widget _buildAdaptiveEmailRow(String label, String email) {
    // Calculate if the email is too long and needs smaller font
    final bool needsSmallFont = _isEmailTooLong(email);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: AppFonts.primaryFontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.Neutral400,
          ),
        ),
        Expanded(
          child: Text(
            email,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: AppFonts.primaryFontFamily,
              fontSize:
                  needsSmallFont ? 11 : 14, // Smaller font for long emails
              fontWeight: FontWeight.w400,
              color: AppColors.Neutral300,
            ),
            overflow:
                TextOverflow.ellipsis, // Fallback in case it still overflows
          ),
        ),
      ],
    );
  }

  /// Helper method to determine if email is too long and needs smaller font
  bool _isEmailTooLong(String email) {
    // You can adjust this threshold based on your layout
    const int maxComfortableLength = 25;
    return email.length > maxComfortableLength;
  }
}
