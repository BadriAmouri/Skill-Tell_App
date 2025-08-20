// profile_screen.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:snt_app/Screens/profile_settings.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = "bessie.cooper@ensia.edu.dz";
  String username = "Bessie Cooper";
  List<String> skills = ["Leadership", "UX Design"];
  List<String> interests = ["Basketball", "Reading"];
  Uint8List? avatarBytes; // <— updated here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const SizedBox(width: 16),
              const Text("Profile", style: TextStyle(fontFamily:'Poppins',fontSize:18,fontWeight:FontWeight.w600,color: Colors.white)),
              IconButton(icon: const Icon(Icons.send_outlined,color: Colors.white,size:24), onPressed: () => Navigator.pop(context)),
            ]),
            const SizedBox(height: 120),

            Stack(clipBehavior: Clip.none, children: [
              Container(
                height: 760,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0,4))],
                ),
                child: Column(children: [
                  const SizedBox(height: 40),
                  Text(username, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const Text("member", style: TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 20),
                  _infoCard(icon: Icons.email_outlined, label: "Email", value: email),
                  const SizedBox(height: 30),
                  _infoCard(icon: Icons.stacked_bar_chart_rounded, label: "Department", value: "UI/UX design"),
                  const SizedBox(height: 30),

                  // Skills
                  _tagsCard(title: "Skills", icon: Icons.build_rounded, tags: skills),
                  const SizedBox(height: 20),
                  // Interests
                  _tagsCard(title: "Interests", icon: Icons.favorite_border, tags: interests),
                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7A5AF8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                      ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Settings", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Poppins', color: Colors.white)),
                          SizedBox(width: 8),
                          Icon(Icons.settings_outlined, color: Colors.white, size: 20),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),

              // ——— Avatar showing picked image ———
              Positioned(
                top: -60, left: 0, right: 0,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 53,
                    backgroundImage: avatarBytes != null
                        ? MemoryImage(avatarBytes!)
                        : const NetworkImage('https://via.placeholder.com/150') as ImageProvider,
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ]),
      bottomNavigationBar: BottomNavBar(currentIndex: 3,)
    );
  }

  static Widget _infoCard({required IconData icon, required String label, required String value}) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 24),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300, width: 1),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, spreadRadius: 0.5, offset: const Offset(0, 2))],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Icon(icon, color: Colors.black54), const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Poppins')),
      ]),
      const SizedBox(height: 8),
      Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.black54, fontFamily: 'Poppins')),
    ]),
  );

  static Widget _tagsCard({required String title, required IconData icon, required List<String> tags}) {
    final colors = [Colors.orange, Colors.purple, Colors.red, Colors.green];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, spreadRadius: 0.5, offset: const Offset(0, 2))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, color: Colors.black54), const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'Poppins')),
        ]),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: List.generate(tags.length, (i) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              color: colors[i % colors.length].withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors[i]),
            ),
            child: Text(tags[i], style: TextStyle(color: colors[i], fontWeight: FontWeight.w500, fontSize: 12)),
          )),
        ),
      ]),
    );
  }
}
