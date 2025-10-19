import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snt_app/Models/user_model.dart';
import 'package:snt_app/Screens/Profile/Profile_Settings.dart';
import 'package:snt_app/Services/ProfilePictureService.dart';
import 'package:snt_app/Services/shared_prefs_service.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // A single Future to fetch all data needed for this screen.
  late Future<Map<String, dynamic>> _dataFuture;

  // Instances of our services.
  final _profilePictureService = ProfilePictureService();
  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Start fetching data as soon as the screen is initialized.
    _dataFuture = _loadAllData();
  }

  /// Fetches both the UserModel and the profile picture concurrently.
  Future<Map<String, dynamic>> _loadAllData() async {
    final results = await Future.wait([
      SharedPrefsService.getUser(),
      _profilePictureService.loadProfilePicture(),
    ]);
    return {
      'user': results[0] as UserModel?,
      'avatar': results[1] as Uint8List?,
    };
  }

  /// Refreshes the screen's data. Called after an update (e.g., settings change).
  void _refreshData() {
    setState(() {
      _dataFuture = _loadAllData();
    });
  }

  /// Handles picking a new image from the gallery, saving it, and refreshing the UI.
  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      final bytes = await image.readAsBytes();
      await _profilePictureService.saveProfilePicture(bytes);
      _refreshData(); // Refresh all data to show the new picture
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No data found."));
          }

          final UserModel? user = snapshot.data!['user'];
          final Uint8List? avatarBytes = snapshot.data!['avatar'];

          // If the user is null, they might be logged out.
          if (user == null) {
            return const Center(child: Text("User not found. Please log in."));
          }

          // If data is loaded, build the main UI.
          return _buildProfileView(user, avatarBytes);
        },
      ),
    );
  }

  /// The main UI widget, built with dynamic data.
  Widget _buildProfileView(UserModel user, Uint8List? avatarBytes) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'lib/Assets/Images/backgroundContact.png',
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: AppFonts.primaryFontFamily,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: SizedBox(
                      height: 110,
                      width: 110,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 53,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  avatarBytes != null
                                      ? MemoryImage(avatarBytes)
                                      : null,
                              child:
                                  avatarBytes == null
                                      ? const Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.grey,
                                      )
                                      : null,
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.Main500,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        user.username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.primaryFontFamily,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.role,
                        style: const TextStyle(
                          color: AppColors.Text400,
                          fontSize: 13,
                          fontFamily: AppFonts.primaryFontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoCard(
                        icon: Icons.email_outlined,
                        label: "Email",
                        value: user.email,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        icon: Icons.business_center_outlined,
                        label: "Department",
                        value: user.department ?? 'N/A',
                      ),
                      const SizedBox(height: 16),
                      _buildTagsCard(
                        icon: Icons.star_outline,
                        title: "Skills",
                        tags: user.skills,
                      ),
                      const SizedBox(height: 16),
                      _buildTagsCard(
                        icon: Icons.favorite_outline,
                        title: "Interests",
                        tags: user.interests,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(width: double.infinity, height: 50),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Your helper widgets (_buildInfoCard, _buildTagsCard) remain unchanged.
  // ... (paste your existing helper widgets here)
  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.Text300.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColors.Text500),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.primaryFontFamily,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.Text400,
                fontFamily: AppFonts.primaryFontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsCard({
    required IconData icon,
    required String title,
    required List<String> tags,
  }) {
    final tagColors = [
      {
        'bg': const Color(0xFFFFF4E6),
        'border': const Color(0xFFFF9E00),
        'text': const Color(0xFFFF9E00),
      },
      {
        'bg': const Color(0xFFF3E5F5),
        'border': const Color(0xFF9D4EDD),
        'text': const Color(0xFF9D4EDD),
      },
      {
        'bg': const Color(0xFFFFEBEE),
        'border': const Color(0xFFDD3030),
        'text': const Color(0xFFDD3030),
      },
      {
        'bg': const Color(0xFFE8F5E9),
        'border': const Color(0xFF00C851),
        'text': const Color(0xFF00C851),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.Text300.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColors.Text500),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.primaryFontFamily,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(tags.length, (i) {
              final colorSet = tagColors[i % tagColors.length];
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorSet['bg'] as Color,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorSet['border'] as Color,
                    width: 1,
                  ),
                ),
                child: Text(
                  tags[i],
                  style: TextStyle(
                    color: colorSet['text'] as Color,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    fontFamily: AppFonts.primaryFontFamily,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
