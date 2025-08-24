import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snt_app/Screens/Home/home_screen.dart';
import 'package:snt_app/Widgets/General/button.dart';
import 'package:snt_app/Widgets/General/input.dart';
import 'package:snt_app/Widgets/SignUp&LogIn/custom_scaffold.dart';
import 'package:snt_app/Theme/theme.dart';

class YourInfo extends StatefulWidget {
  const YourInfo({super.key});

  @override
  State<YourInfo> createState() => _YourInfoState();
}

class _YourInfoState extends State<YourInfo> {
  int hoveredIndex = -1;
  bool isRoleOpen = false;
  bool isDepartmentOpen = false;
  late String selectedRole;
  late String selectedDepartment;
  bool _showUsernameError = false;
  bool _showSkillsError = false;

  final List<String> roles = [
    "Member",
    "Manager",
    "Co-Manager",
    "President",
    "Vice president",
    "Secretary general",
    "Other"
  ];

  final List<String> departments = [
    "UI/UX Design",
    "Graphic design",
    "Marketing",
    "Logistics",
    "Production",
    "Sponsoring",
    "Media",
    "Communication",
    "HR",
    "AI",
    "Relax",
    "Dev",
    "Planning",
    "Event"
  ];

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();   // NEW
  final TextEditingController phoneController = TextEditingController(); // NEW
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController interestsController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    dobController.dispose();     // NEW
    phoneController.dispose();   // NEW
    skillsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedRole = roles.first;
    selectedDepartment = departments.first;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      zoomheight: true,
      isLogin: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar with back + title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    'lib/Assets/Icons/arrowLeft_.svg',
                    width: 25,
                    height: 25,
                  ),
                ),
                Text(
                  "Your Info",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: AppColors.Text500,
                  ),
                ),
                const SizedBox(width: 25, height: 25),
              ],
            ),
            const SizedBox(height: 8),

            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Lorem ipsum dolor sit amet consectetur. Tellus leo vitae aliquet vel tortor. Interdum tempus Interdum tempus",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: AppColors.Text400,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Username
            Text(
              "Username",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: AppColors.Text400,
              ),
            ),
            const SizedBox(height: 6),
            Input(
              prefixIcon: 'lib/Assets/Icons/profile_.svg',
              placeholder: 'username',
              controller: usernameController,
            ),
            if (_showUsernameError)
              Text(
                "This field is required",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: AppColors.Error100,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              "Date of Birth",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: AppColors.Text400,
              ),
            ),
            const SizedBox(height: 6),
            Input(
              prefixIcon: 'lib/Assets/Icons/Calendar.svg', // add a calendar icon to assets
              placeholder: 'DD/MM/YYYY',
              controller: dobController,
            ),
            const SizedBox(height: 10),

            Text(
              "Phone Number",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: AppColors.Text400,
              ),
            ),
            const SizedBox(height: 6),
            Input(
              prefixIcon: 'lib/Assets/Icons/Call.svg', // add a phone icon to assets
              placeholder: '+123 456 7890',
              controller: phoneController,
            ),
            const SizedBox(height: 10),

            // Role dropdown
            Text(
              "Role",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: AppColors.Text400,
              ),
            ),
            const SizedBox(height: 6),
            _buildDropdown(
              icon: 'lib/Assets/Icons/Member.svg',
              value: selectedRole,
              items: roles,
              isOpen: isRoleOpen,
              onTap: () => setState(() => isRoleOpen = !isRoleOpen),
              onSelect: (val) {
                setState(() {
                  selectedRole = val;
                  isRoleOpen = false;
                });
              },
            ),
            const SizedBox(height: 10),

            // Department dropdown
            Text(
              "Department",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: AppColors.Text400,
              ),
            ),
            const SizedBox(height: 6),
            _buildDropdown(
              icon: 'lib/Assets/Icons/Chart.svg',
              value: selectedDepartment,
              items: departments,
              isOpen: isDepartmentOpen,
              onTap: () => setState(() => isDepartmentOpen = !isDepartmentOpen),
              onSelect: (val) {
                setState(() {
                  selectedDepartment = val;
                  isDepartmentOpen = false;
                });
              },
            ),
            const SizedBox(height: 10),

            // Skills
            Text(
              "Skills",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: AppColors.Text400,
              ),
            ),
            const SizedBox(height: 6),
            Input(
              prefixIcon: 'lib/Assets/Icons/skills_.svg',
              placeholder: 'e.g., Leadership, UX Design,',
              controller: skillsController,
            ),
            if (_showSkillsError)
              Text(
                "This field is required",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: AppColors.Error100,
                ),
            ),

            const SizedBox(height: 10),

            // Skills
            Text(
              "Interests",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: AppColors.Text400,
              ),
            ),
            const SizedBox(height: 6),
            Input(
              prefixIcon: 'lib/Assets/Icons/skills_.svg',
              placeholder: 'e.g., Basketball, Reading',
              controller: interestsController,
            ),
            if (_showSkillsError)
              Text(
                "This field is required",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: AppColors.Error100,
                ),
            ),
            
            const SizedBox(height: 40),

            // Button
            Button(
              onTap: () {
                setState(() {
                  _showUsernameError = usernameController.text.isEmpty;
                  _showSkillsError = skillsController.text.isEmpty;
                });

                if (!_showUsernameError && !_showSkillsError) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                  );
                }
              },
              buttonText: "Sign up",
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable dropdown widget
  Widget _buildDropdown({
    required String icon,
    required String value,
    required List<String> items,
    required bool isOpen,
    required VoidCallback onTap,
    required Function(String) onSelect,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.Text300, width: 1),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                SvgPicture.asset(icon, width: 20, height: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: AppColors.Text300,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isOpen ? 0.25 : 0,
                  duration: const Duration(milliseconds: 100),
                  child: SvgPicture.asset('lib/Assets/Icons/arrowDown_.svg'),
                ),
              ],
            ),
          ),
        ),
        if (isOpen)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
              border: const Border(
                left: BorderSide(color: AppColors.Text300),
                right: BorderSide(color: AppColors.Text300),
                bottom: BorderSide(color: AppColors.Text300),
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.2,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () => onSelect(item),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: AppColors.Text300,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
