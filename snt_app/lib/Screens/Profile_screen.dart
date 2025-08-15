import 'package:flutter/material.dart';
import 'package:snt_app/Theme/theme.dart';
import 'package:snt_app/Components/BottomNavBar.dart';
import 'package:snt_app/Screens/Profile_Settings.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Layer 1: Background image
          Container(
            height: 1450,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/Assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Layer 2: Scrollable content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 16),
                    const Text(
                      "Profile",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send_outlined, color: Colors.white, size: 24),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 120),

                // White container with overlapping profile image
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 700,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 40), // space for profile pic
                          const Text(
                            "Bessie Cooper",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            "member",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                
                          // Email
                          _infoCard(
                            icon: Icons.email_outlined,
                            label: "Email",
                            value: "bessie.cooper@ensia.edu.dz",
                          ),
                          const SizedBox(height: 30),
                
                          // Department
                          _infoCard(
                            icon: Icons.stacked_bar_chart_rounded,
                            label: "Department",
                            value: "UI/UX design",
                          ),
                          const SizedBox(height: 30),
                
                          // Skills
                          _skillsCard([
                            "Leadership",
                            "UX Design",
                            "Basketball",
                            "Reading"
                          ]),
                          const SizedBox(height: 30),
                
                          // Settings button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.Main400,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Settings",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.settings_outlined, color: Colors.white, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    // Positioned profile image
                    Positioned(
                      top: -60,
                      left: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: const CircleAvatar(
                          radius: 53,
                          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom navigation bar
      bottomNavigationBar: CustomBottomNavBar(
    currentIndex: 3,
    onTap: (index) {},
    onHomePressed: () {
      // Handle home press
    },
  ),
    );
  }

  static Widget _infoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1 ),
        boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // soft shadow colour
          blurRadius: 4,
          spreadRadius: 0.5, // how soft the shadow is
          offset: const Offset(0, 2), // horizontal & vertical offset
        ),
      ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children:[ 
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 8),
          Text(label,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Poppins')),],),
                    SizedBox(height: 8,),
          Text(value,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w300, color: Colors.black54, fontFamily: 'Poppins')),
        ],
      ),
    );
  }

  static Widget _skillsCard(List<String> skills) {
    final colors = [
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.green,
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow:
        [ BoxShadow(color: Colors.black.withOpacity(0.1), // soft shadow colour
          blurRadius: 4,
          spreadRadius: 0.5, // how soft the shadow is
          offset: const Offset(0, 2),)]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.heart_broken, color: Colors.black54),
              SizedBox(width: 8,),
              const Text("Skills and interests",
                  style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'Poppins')),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              skills.length,
              (index) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: colors[index % colors.length].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colors[index]),
                ),
                child: Text(
                  skills[index],
                  style: TextStyle(
                      color: colors[index], fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
