import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onHomePressed;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.onHomePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      height: 90, // more space for overflow
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
                    _navItem(Icons.credit_card_rounded, "Card", 0),
                    _navItem(Icons.notifications_outlined, "Notifications", 1),
                    const SizedBox(width: 48), // space for FAB
                    _navItem(Icons.call_outlined, "Contacts", 2),
                    _navItem(Icons.person_outline, "Profile", 3),
                  ],
                ),
              ),
            ),
          ),

          // Floating Home Button
          Positioned(
            top: -15,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: onHomePressed,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.Main400 ,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.home_filled,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isActive = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.Main400 : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ?  AppColors.Main400 : Colors.grey,
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

    // --- Draw manual dark shadow ---
    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15); // Strong blur

    // Shift shadow slightly down
    canvas.save();
    canvas.translate(0, 4);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    // --- Draw navbar background ---
    Paint bgPaint = Paint()..color = Colors.white;
    canvas.drawPath(path, bgPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
