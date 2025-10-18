import 'package:flutter/material.dart';
import 'package:snt_app/Screens/Contacts/contacts_screen.dart'; // Ensure this path is correct
import 'package:snt_app/Widgets/General/bottom_navbar.dart';
import 'Contacts/qr_code_screen.dart'; // Ensure this path is correct

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}