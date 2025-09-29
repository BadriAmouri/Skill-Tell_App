import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'qr_code_screen.dart';

// Contacts Screen for displaying club information, stats, and social links
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {

  final _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex), // Add this line
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
              padding: const EdgeInsets.only(top: 60.0, left: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  // ===== AppBar Section (Title + QR Icon) =====
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        // Center Title
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Contacts",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: AppFonts.primaryFontFamily,
                            ),
                          ),
                        ),
                        // Right QR Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: IconButton(
                              icon: Image.asset(
                                'lib/Assets/Images/Send.png',
                                width: 24,
                                height: 24,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Navigate to QR Code Screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const QrCodeScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ===== Logo + Social Links Section =====
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Club Logo
                          Center(
                            child: Image.asset(
                              'lib/Assets/Images/logo.png',
                              width: 200,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                          // Social Icons Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Instagram
                              _buildSocialIcon(
                                icon: 'lib/Assets/Images/_Instagram.png',
                                onTap: () async {
                                  final Uri url = Uri.parse('https://www.instagram.com/skillntell.club');
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url, mode: LaunchMode.externalApplication);
                                  }
                                },
                              ),
                              SizedBox(width: 24),
                              // Gmail
                              _buildSocialIcon(
                                icon: 'lib/Assets/Images/Gmail.png',
                                onTap: () async {
                                  final Uri url = Uri.parse('mailto:skill.and.tell@ensia.edu.dz');
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url, mode: LaunchMode.externalApplication);
                                  }
                                },
                              ),
                              SizedBox(width: 24),
                              // LinkedIn
                              _buildSocialIcon(
                                icon: 'lib/Assets/Images/LinkedIn.png',
                                onTap: () async {
                                  final Uri url = Uri.parse(
                                      'https://www.linkedin.com/company/skill-tell-club/posts/?feedView=all');
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url, mode: LaunchMode.externalApplication);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ===== Statistics + About/Vision/Mission =====
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // ===== Section Title =====
                          Center(
                            child: Text(
                              "Skill and Tell in numbers",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF657084),
                                fontFamily: AppFonts.primaryFontFamily,
                                height: 1.5,
                              ),
                            ),
                          ),

                          // ===== Numbers Row =====
                          Container(
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('lib/Assets/Images/backgroundS&TNumbers.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildNumberStat("Members", "300"),
                                Container(
                                  height: 50,
                                  width: 1,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                _buildNumberStat("Departments", "6"),
                                Container(
                                  height: 50,
                                  width: 1,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                _buildNumberStat("Events", "28"),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),

                          // ===== About Section =====
                          _buildTextSection(
                            title: "About",
                            text:
                               "Founded in March 2022, the Skill&Tell Club brings together students passionate about artificial intelligence and new technologies. Its mission is to promote learning, collaboration, and the dissemination of AI knowledge through innovative projects. Our goal is to create an environment conducive to learning, experimentation, and collaboration while encouraging students to apply AI to solve real-world problems"
                          ),

                          const SizedBox(height: 20),

                          // ===== Vision Section =====
                          _buildTextSection(
                            title: "Vision",
                            text:
                                "Skill&Tell Club is a unique space where learning meets fun. Our goals include:\n\n" +
                                "• Organizing high-quality events that dynamically emphasize the importance of skills development and personal growth.\n\n" +
                                "• Providing a wide range of training sessions, both internal and external, focused on essential skills for success across diverse domains.\n\n" +
                                "• Maintaining educational continuity on social media to inspire and introduce a larger audience to the exciting world of skill development and personal growth.\n\n" +
                                "• Creating a collaborative space for students to share their knowledge and skills, fostering mutual exchange and enrichment.\n\n" +
                                "• Building a strong and cohesive community where members can learn from each other, share experiences, and grow together toward excellence.",
                          ),

                          const SizedBox(height: 20),

                          // ===== Values Section =====
                          _buildTextSection(
                            title: "OUR VALUES",
                            text:
                                "• Curiosity and creativity\n\n" +
                                "• Teamwork\n\n" +
                                "• Sharing knowledge and skills\n\n" +
                                "• Making a positive impact on the community\n\n" +
                                "• Excellence and inclusion",
                          ),

                          const SizedBox(height: 20),

                          // ===== Mission Section =====
                          _buildTextSection(
                            title: "Mission",
                            text:
                                "Lorem ipsum dolor sit amet, consectetur. Dignissim curabitur pellentesque semper aliquam egestas. A massa at tempor sem eu volutpat egestas massa. Diam id varius ut sed. Nunc dictumt aenean ut amet vel eu tempus libero. massa at tempor sem eu volutpat egestas massa. Diam id varius ut sed. Nunc dictumt aenean ut amet vel eu tempus libero.",
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

  // ===== Reusable Widget: Number Stat (e.g., Members, Departments, Events) =====
  Widget _buildNumberStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFeddbff),
            fontFamily: AppFonts.primaryFontFamily,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.normal,
            color: Color(0xFFD7AEFF),
            fontFamily: AppFonts.primaryFontFamily,
          ),
        ),
      ],
    );
  }

  // ===== Reusable Widget: Social Icon Button =====
  Widget _buildSocialIcon({required String icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        icon,
        width: 32,
        height: 32,
      ),
    );
  }

  // ===== Reusable Widget: Text Sections (About, Vision, Mission) =====
  Widget _buildTextSection({required String title, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF6D00),
            fontFamily: AppFonts.primaryFontFamily,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF657084),
            fontFamily: AppFonts.primaryFontFamily,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
