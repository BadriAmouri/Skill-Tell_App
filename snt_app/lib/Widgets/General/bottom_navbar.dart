import 'package:flutter/material.dart';
import 'package:snt_app/Screens/empty_screen.dart';
import 'package:snt_app/Screens/home_screen.dart';
import 'package:snt_app/Theme/theme.dart';

class BottomNavBar extends StatelessWidget {
  
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

        currentIndex: currentIndex,
        onTap: (int index) {
          if(index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
          else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EmptyScreen(selectedIndex: index,)),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.Main500,
        unselectedItemColor: AppColors.Neutral400,

        items: [
             BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: "Card",
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: "Contacts",
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            ),
        ],
    );
  }
}