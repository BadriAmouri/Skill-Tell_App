import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snt_app/Screens/Card/profile_card_screen.dart';
import 'package:snt_app/Screens/Home/home_screen.dart';
import 'package:snt_app/Screens/Profile/Profile_screen.dart';
import 'package:snt_app/Screens/empty_screen.dart';
import 'package:snt_app/Screens/Notifications/notifications.dart';

import 'package:snt_app/Theme/theme.dart';
class BottomNavBar extends StatelessWidget {

  final int currentIndex;

  void onTap(int index, BuildContext context) {
  if (index == 0) {
    // Navigate to NotificationsPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfileCard()),
    );
  } 
  else if (index == 1) {
    // Navigate to NotificationsPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NotificationsPage()),
    );
  } 
  else if (index == 3) {
    // Navigate to NotificationsPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  } 
  else {
    // Default navigation for other indexes
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => EmptyScreen(selectedIndex: index)),
    );
  }
  }

  const BottomNavBar({
    
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      height: 90, // give actual space for navbar
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: _NavBarPainter(),
              child: SizedBox(
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem('lib/Assets/Icons/solar_card-outline.svg', "Card", 0, context),
                    _navItem('lib/Assets/Icons/Notification.svg', "Notifications", 1, context),
                    const SizedBox(width: 48), // space for FAB
                    _navItem('lib/Assets/Icons/Call.svg', "Contacts", 2, context),
                    _navItem('lib/Assets/Icons/Profile.svg', "Profile", 3, context),
                  ],
                ),
              ),
            ),
          ),

          // Floating Home Button
          Positioned(
            top: -12, // just slightly above the navbar
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.Main400,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('lib/Assets/Icons/Home.png', width: 15, height: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }

  Widget _navItem(String icon, String label, int index, BuildContext context) {
    final isActive = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index, context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            color: isActive ? AppColors.Main400 : AppColors.Neutral400,
            width: 20,
            height: 20,
          ),
          Text(
            label,
            style: TextStyle(
              color: isActive ?  AppColors.Main400 : AppColors.Neutral400,
              fontSize: 12,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
class _NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double fabRadius = 40.0;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo((size.width / 2) - fabRadius - 20, 0);

    // Left curve into the cutout
    path.quadraticBezierTo(
      (size.width / 2) - fabRadius - 10, 0,
      (size.width / 2) - fabRadius, 20,
    );

    // Big central arc for the home button
    path.arcToPoint(
      Offset((size.width / 2) + fabRadius, 20),
      radius: const Radius.circular(50),
      clockwise: false,
    );

    // Right curve out of the cutout
    path.quadraticBezierTo(
      (size.width / 2) + fabRadius + 10, 0,
      (size.width / 2) + fabRadius + 20, 0,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    Paint shadowPaint = Paint()
      ..color = Color.fromRGBO(0, 0, 0, 0.1) // opacity = 0.1
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10); // blur = 10

    canvas.save();
    canvas.translate(0, -5); // Y offset = -5 (move shadow up)
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    // --- Draw navbar background ---
    Paint bgPaint = Paint()..color = Color.fromRGBO(250, 252, 255, 1);
    canvas.drawPath(path, bgPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}