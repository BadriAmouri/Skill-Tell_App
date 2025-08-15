import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Components/BottomNavBar.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool darkMode = false;
  bool dataSaver = false;

  int currentIndex = 3; // Profile tab selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 191, 199, 212)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Color.fromARGB(255, 191, 199, 212), fontWeight: FontWeight.w500, fontFamily: 'Poppins', fontSize: 16),
        ),
        centerTitle: true,
      ),
      body:
       SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Profile settings", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Poppins', color: Color.fromARGB(255, 191, 199, 212))),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 191, 199, 212),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _buildTextField(Icons.email, "Email", "bessie.cooper@gmail.com"),
            const SizedBox(height: 20),
            _buildTextField(Icons.person, "Username", "Bessie Cooper"),
            const SizedBox(height: 20),
            _buildTextField(Icons.favorite, "Skills and Interests",
                "e.g., Leadership, UX Design, Basketball, Reading"),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            const Text("General settings", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildSwitchTile(Icons.notifications, "Enable notifications", notificationsEnabled, (val) {
              setState(() => notificationsEnabled = val);
            }),
            _buildSwitchTile(Icons.dark_mode, "Dark mode", darkMode, (val) {
              setState(() => darkMode = val);
            }),
            _buildSwitchTile(Icons.data_usage, "Data saver", dataSaver, (val) {
              setState(() => dataSaver = val);
            }),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Log out", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          // Handle navigation logic here
        },
        onHomePressed: () {
          Navigator.pushReplacementNamed(context, '/home'); // Adjust as needed
        },
      ),
    );
  }

 Widget _buildTextField(IconData icon, String label, String value) {
  return TextField(
    style: const TextStyle(
      color: Color.fromARGB(255, 191, 199, 212), // Grey text
      fontFamily: 'Poppins',
      fontSize: 12,
    ),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Color.fromARGB(255, 191, 199, 212), // Grey label
        fontFamily: 'Poppins',
        fontSize: 14,
      ),
      prefixIcon: Icon(
        icon,
        color: Color.fromARGB(255, 191, 199, 212), // Grey icon
      ),
      filled: false,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 191, 199, 212),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 191, 199, 212),
          width: 1,
        ),
      ),
    ),
    controller: TextEditingController(text: value),
  );
}

  Widget _buildSwitchTile(IconData icon, String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: Icon(icon, color: Colors.purple),
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.purple,
    );
  }
}