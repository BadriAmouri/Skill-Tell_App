import 'package:flutter/material.dart';
import 'package:snt_app/Screens/contacts_screen.dart'; // Ensure this path is correct
import './qr_code_screen.dart'; // Ensure this path is correct
import './../Components/BottomNavBar.dart'; // Ensure this path is correct

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  // Default to ContactsScreen (index 2)
  int _selectedIndex = 2;

  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Card Screen')), // Index 0
    Center(child: Text('Notifications Screen')), // Index 1
    ContactsScreen(), // Index 2
    QrCodeScreen(), // Index 3
    Center(child: Text('Profile Screen')), // Index 4
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onHomePressed() {
    // Example: navigate to Card screen (index 0)
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex], // Display the selected screen
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        onHomePressed: _onHomePressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}