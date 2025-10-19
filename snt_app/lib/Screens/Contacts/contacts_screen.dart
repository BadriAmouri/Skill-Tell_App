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
                  // ===== AppBar Section (Title + QR Icon) =====
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        // Center Title
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "About us",
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

                  const SizedBox(height: 20),

                  // ===== Logo + Social Links Section =====
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Club Logo
                        Image.asset(
                          'lib/Assets/Images/logo.png',
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(height: 16),
                        // Social Icons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialIcon(
                              icon: 'lib/Assets/Images/_Instagram.png',
                              onTap: () async {
                                final Uri url = Uri.parse(
                                  'https://www.instagram.com/skillntell.club',
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                            ),
                            const SizedBox(width: 20),
                            _buildSocialIcon(
                              icon: 'lib/Assets/Images/Gmail.png',
                              onTap: () async {
                                final Uri url = Uri.parse(
                                  'mailto:skill.and.tell@ensia.edu.dz',
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                            ),
                            const SizedBox(width: 20),
                            _buildSocialIcon(
                              icon: 'lib/Assets/Images/LinkedIn.png',
                              onTap: () async {
                                final Uri url = Uri.parse(
                                  'https://www.linkedin.com/company/skill-tell-club/posts/?feedView=all',
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== Statistics Section =====
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Section Header
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6A1B9A),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            "Skill and Tell in Numbers",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: AppFonts.primaryFontFamily,
                            ),
                          ),
                        ),
                        // Numbers
                        Container(
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/Assets/Images/backgroundS&TNumbers.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildNumberStat("Members", "300"),
                              _buildVerticalDivider(),
                              _buildNumberStat("Departments", "6"),
                              _buildVerticalDivider(),
                              _buildNumberStat("Events", "28"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== About/Vision/Values Sections =====
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // About Section
                        _buildTextSection(
                          title: "About",
                          text:
                              "Founded in 2022, Skill&Tell Club brings together students passionate about AI and technology. We promote learning, collaboration, and innovation through projects and events, creating an environment where students can apply AI to solve real-world problems.",
                        ),

                        const SizedBox(height: 24),

                        // Vision Section
                        _buildTextSection(
                          title: "Vision",
                          text:
                              "A space where learning meets fun. We organize quality events, provide training sessions, maintain educational content on social media, and foster a collaborative community for skill development and personal growth.",
                        ),

                        const SizedBox(height: 24),

                        // Values Section
                        _buildTextSection(
                          title: "Our Values",
                          text:
                              "• Curiosity & Creativity\n• Teamwork & Collaboration\n• Knowledge Sharing\n• Community Impact\n• Excellence & Inclusion",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== Reusable Widget: Number Stat =====
  Widget _buildNumberStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFD7AEFF),
            fontFamily: AppFonts.primaryFontFamily,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFFeddbff),
            fontFamily: AppFonts.primaryFontFamily,
          ),
        ),
      ],
    );
  }

  // ===== Vertical Divider =====
  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withOpacity(0.3),
    );
  }

  // ===== Reusable Widget: Social Icon Button =====
  Widget _buildSocialIcon({required String icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(icon, width: 28, height: 28),
      ),
    );
  }

  // ===== Reusable Widget: Text Sections =====
  Widget _buildTextSection({required String title, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFF6D00).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFF6D00),
              fontFamily: AppFonts.primaryFontFamily,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontFamily: AppFonts.primaryFontFamily,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
