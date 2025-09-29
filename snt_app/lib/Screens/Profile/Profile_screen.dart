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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Profile'),
      body: Stack(children: [
        Container(
          height: 1450,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/Assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 100),
            Stack(clipBehavior: Clip.none, children: [
              Container(
                height: 760,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: Column(children: [
                  const SizedBox(height: 40),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Text(
                    "member",
                    style: TextStyle(
                      color: AppColors.Text400,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 20),
                  _infoCard(
                    iconPath: 'lib/Assets/Icons/email_.svg',
                    label: "Email",
                    value: email,
                  ),
                  const SizedBox(height: 30),
                  _infoCard(
                    iconPath: 'lib/Assets/Icons/department_.svg',
                    label: "Department",
                    value: "UI/UX design",
                  ),
                  const SizedBox(height: 30),
                  _tagsCard(
                    title: "Skills",
                    iconPath: 'lib/Assets/Icons/skills_.svg',
                    tags: skills,
                  ),
                  const SizedBox(height: 20),
                  _tagsCard(
                    title: "Interests",
                    iconPath: 'lib/Assets/Icons/interests_.svg',
                    tags: interests,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Button(
                      onTap: () async {
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
                      buttonText: "Settings",
                    ),
                  ),
                ]),
              ),
              // MODIFIED AVATAR WIDGET
              Positioned(
                top: -60,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 53,
                                backgroundImage: avatarBytes != null
                                    ? MemoryImage(avatarBytes!)
                                    : const NetworkImage(
                                            'https://via.placeholder.com/150')
                                        as ImageProvider,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.Accent300,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ]),
        ),
      ]),
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
    );
  }

  static Widget _infoCard({
    required String iconPath,
    required String label,
    required String value,
  }) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.Text300, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 4,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            SvgPicture.asset(
              iconPath,
              width: 20,
              height: 20,
              color: Colors.black,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ]),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: AppColors.Text400,
              fontFamily: 'Poppins',
            ),
          ),
        ]),
      );

  static Widget _tagsCard({
    required String title,
    required String iconPath,
    required List<String> tags,
  }) {
    final colors = [Colors.orange, Colors.purple, Colors.red, Colors.green];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.Text300),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          SvgPicture.asset(
            iconPath,
            width: 20,
            height: 20,
            color: Colors.black,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ]),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            tags.length,
            (i) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: colors[i % colors.length].withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colors[i]),
              ),
              child: Text(
                tags[i],
                style: TextStyle(
                  color: colors[i],
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}