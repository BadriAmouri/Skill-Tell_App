import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import '../Components/BottomNavBar.dart';

// ===== Centralized Colors for Design =====
class DesignColors {
  static const Color accentOrange = Color(0xFFF39C12);
  static const Color appBarBg = Color(0xFFF8F9FA);
  static const Color appBarTitle = Color(0xFF343A40);
  static const Color cardBgStart = Color.fromARGB(255, 75, 33, 131);
  static const Color cardBgEnd = Color.fromARGB(255, 48, 20, 83);
  static const Color scanMeText = Color(0xFFD8BFD8);
}

// ===== Main QR Code Screen =====
class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  int _selectedIndex = 3;

  // Handle bottom nav bar item taps
  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // Handle home button press
  void _onHomePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: DesignColors.appBarBg,

      // ===== AppBar =====
      appBar: AppBar(
        title: const Text(
          'Skill&Tell QR code',
          style: TextStyle(
            color: DesignColors.appBarTitle,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: DesignColors.appBarBg,
        elevation: 1.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: DesignColors.appBarTitle),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      // ===== Body Content =====
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 70, left: 20, right: 20),
          child: _buildQrCard(context, screenWidth),
        ),
      ),

      // ===== Bottom Navigation Bar =====
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        onHomePressed: _onHomePressed,
      ),
    );
  }

  // ===== Helper: Create Decorative Bokeh Circles =====
  Widget _buildBokehCircle({
    required Color color,
    required double size,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }

  // ===== Helper: Build Main QR Code Card =====
  Widget _buildQrCard(BuildContext context, double screenWidth) {
    final cardWidth = screenWidth * 0.9;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: cardWidth,
          color: DesignColors.cardBgEnd,
          child: Stack(
            children: [
              // ===== Background Decorative Circles =====
              _buildBokehCircle(color: Colors.orange.withOpacity(0.2), size: cardWidth * 0.2, top: 40, left: 15),
              _buildBokehCircle(color: Colors.yellow.withOpacity(0.15), size: cardWidth * 0.1, top: 20, right: 90),
              _buildBokehCircle(color: Colors.orange.withOpacity(0.2), size: cardWidth * 0.3, top: 120, left: 60),
              _buildBokehCircle(color: Colors.yellow.withOpacity(0.2), size: cardWidth * 0.25, top: 200, right: 30),
              _buildBokehCircle(color: Colors.orange.withOpacity(0.1), size: cardWidth * 0.15, top: 80, right: 15),
              _buildBokehCircle(color: Colors.yellow.withOpacity(0.15), size: cardWidth * 0.2, bottom: 210, left: 10),
              _buildBokehCircle(color: Colors.orange.withOpacity(0.15), size: cardWidth * 0.35, bottom: 40, left: -40),
              _buildBokehCircle(color: Colors.yellow.withOpacity(0.25), size: cardWidth * 0.25, bottom: 30, right: -20),
              _buildBokehCircle(color: Colors.orange.withOpacity(0.2), size: cardWidth * 0.1, bottom: 150, right: 100),

              // Blur effect over background
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
                child: Container(color: Colors.black.withOpacity(0.0)),
              ),

              // ===== Main Card Content =====
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    Image.asset('lib/Assets/Images/logo.png', height: 75),
                    const SizedBox(height: 30),

                    // ===== QR Code in Dotted Border =====
                    DottedBorder(
                      color: DesignColors.accentOrange,
                      strokeWidth: 2.5,
                      dashPattern: const [12, 8],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(25),
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: QrImageView(
                          data: 'https://www.instagram.com/skillntell.club',
                          version: QrVersions.auto,
                          size: screenWidth * 0.55,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Scan Me text
                    const Text(
                      '- Scan me -',
                      style: TextStyle(
                        color: DesignColors.scanMeText,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ===== Social Media Links =====
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Instagram
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse('https://www.instagram.com/skillntell.club');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            }
                          },
                          child: Image.asset('lib/Assets/Images/_Instagram.png', height: 32),
                        ),
                        // Gmail
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse('mailto:skill.and.tell@ensia.edu.dz');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            }
                          },
                          child: Image.asset('lib/Assets/Images/Gmail.png', height: 32),
                        ),
                        // LinkedIn
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse(
                                'https://www.linkedin.com/company/skill-tell-club/posts/?feedView=all');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            }
                          },
                          child: Image.asset('lib/Assets/Images/LinkedIn.png', height: 32),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
