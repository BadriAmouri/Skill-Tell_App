import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snt_app/Screens/Profile/Profile_Settings.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';
import 'package:snt_app/Widgets/General/button.dart';
import 'package:snt_app/Widgets/General/custom_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = "bessie.cooper@ensia.edu.dz";
  String username = "Bessie Cooper";
  List<String> skills = ["Leadership", "UX Design"];
  List<String> interests = ["Basketball", "Reading"];
  Uint8List? avatarBytes;

  final _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    _loadAvatar();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        avatarBytes = bytes;
      });
      _saveAvatar(bytes);
    }
  }

  Future<void> _saveAvatar(Uint8List bytes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String base64Image = base64Encode(bytes);
    await prefs.setString('avatar', base64Image);
  }

  Future<void> _loadAvatar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString('avatar');
    if (base64Image != null) {
      setState(() {
        avatarBytes = base64Decode(base64Image);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ===== Background Image =====
          Image.asset(
            'lib/Assets/Images/backgroundContact.png',
            fit: BoxFit.cover,
          ),

          // ===== Main Scrollable Content =====
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ===== AppBar Section (Title) =====
                  SizedBox(
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

                  // ===== Avatar Section =====
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: SizedBox(
                        height: 110,
                        width: 110,
                        child: Stack(
                          children: [
                            // Avatar Circle
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
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
                                backgroundImage: avatarBytes != null
                                    ? MemoryImage(avatarBytes!)
                                    : const NetworkImage(
                                            'https://via.placeholder.com/150')
                                        as ImageProvider,
                              ),
                            ),

                            // Camera Icon
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

                  // ===== Profile Info Container =====
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Username
                          Text(
                            username,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFonts.primaryFontFamily,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Member Badge
                          Text(
                            "member",
                            style: TextStyle(
                              color: AppColors.Text400,
                              fontSize: 13,
                              fontFamily: AppFonts.primaryFontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Email Card
                          _buildInfoCard(
                            icon: Icons.email_outlined,
                            label: "Email",
                            value: email,
                          ),

                          const SizedBox(height: 16),

                          // Department Card
                          _buildInfoCard(
                            icon: Icons.business_center_outlined,
                            label: "Department",
                            value: "UI/UX design",
                          ),

                          const SizedBox(height: 16),

                          // Skills Card
                          _buildTagsCard(
                            icon: Icons.star_outline,
                            title: "Skills",
                            tags: skills,
                          ),

                          const SizedBox(height: 16),

                          // Interests Card
                          _buildTagsCard(
                            icon: Icons.favorite_outline,
                            title: "Interests",
                            tags: interests,
                          ),

                          const SizedBox(height: 24),

                          // Settings Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SettingsPage(
                                      initialEmail: email,
                                      initialUsername: username,
                                      initialSkills: skills,
                                      initialInterests: interests,
                                      initialAvatarBytes: avatarBytes,
                                    ),
                                  ),
                                );
                                if (result is SettingsResult) {
                                  setState(() {
                                    email = result.email;
                                    username = result.username;
                                    skills = result.skills;
                                    interests = result.interests;
                                    avatarBytes = result.avatarBytes;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.Main500,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Settings",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFonts.primaryFontFamily,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.settings, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== Reusable Widget: Info Card (Email, Department) =====
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
        border: Border.all(
          color: AppColors.Text300.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: AppColors.Text500,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
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
              style: TextStyle(
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

  // ===== Reusable Widget: Tags Card (Skills, Interests) =====
  Widget _buildTagsCard({
    required IconData icon,
    required String title,
    required List<String> tags,
  }) {
    final tagColors = [
      {
        'bg': const Color(0xFFFFF4E6),
        'border': const Color(0xFFFF9E00),
        'text': const Color(0xFFFF9E00)
      }, // Orange
      {
        'bg': const Color(0xFFF3E5F5),
        'border': const Color(0xFF9D4EDD),
        'text': const Color(0xFF9D4EDD)
      }, // Purple
      {
        'bg': const Color(0xFFFFEBEE),
        'border': const Color(0xFFDD3030),
        'text': const Color(0xFFDD3030)
      }, // Red
      {
        'bg': const Color(0xFFE8F5E9),
        'border': const Color(0xFF00C851),
        'text': const Color(0xFF00C851)
      }, // Green
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.Text300.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: AppColors.Text500,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
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
            children: List.generate(
              tags.length,
              (i) {
                final colorSet = tagColors[i % tagColors.length];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}