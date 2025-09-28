import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';
import 'package:snt_app/Theme/text_styles.dart';
import 'package:snt_app/Theme/theme.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex),
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: AppFonts.primaryFontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.Text400,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.White,
        elevation: 0,
      ),
      body: _buildComingSoonState(),
    );
  }

  Widget _buildComingSoonState() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Club Logo
               Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.Main600.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'lib/Assets/Images/logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              
              const SizedBox(height: 32),
              
              // Title
              const Text(
                "Notifications Coming Soon",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.Text500,
                  fontFamily: AppFonts.primaryFontFamily
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Description
              const Text(
                "We're working on building our notification system to keep you updated with all the latest club news, events, and announcements.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.Text400,
                  height: 1.5,
                  fontFamily: AppFonts.primaryFontFamily,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Additional message
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.Main100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.Main200,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.Main600,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Stay tuned! This feature will be available in an upcoming update.",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.Main600,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.primaryFontFamily
                        ),
                      ),
                    ),
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