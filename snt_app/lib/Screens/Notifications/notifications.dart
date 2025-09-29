import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snt_app/Widgets/General/bottom_navbar.dart';
import 'package:snt_app/Widgets/General/custom_app_bar.dart';
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
      appBar: const CustomAppBar(
        title: 'Notifications',
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex),
      body: _buildEmptyState(),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/Assets/Images/notification_bg.png'), // Replace with your background image path
          fit: BoxFit.cover,
          opacity: 0.3, // Adjust opacity if needed
        ),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [
              AppColors.Main200.withOpacity(0.3),
              AppColors.Main100.withOpacity(0.2),
              AppColors.White.withOpacity(0.0),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bell illustration
                Image.asset(
                  'lib/Assets/Images/no_notification.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                
                const SizedBox(height: 32),
                
                // Title
                Text(
                  "You're all caught up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: AppColors.Text500,
                    fontFamily: AppFonts.primaryFontFamily,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Description
                Text(
                  "We're building our notification system to keep you updated with club news and events.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.Text400,
                    height: 1.5,
                    fontFamily: AppFonts.primaryFontFamily,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
    );
    
  }
}