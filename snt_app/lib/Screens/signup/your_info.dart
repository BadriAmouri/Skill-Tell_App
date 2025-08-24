import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snt_app/Models/department_model.dart';
import 'package:snt_app/Screens/Home/home_screen.dart';
import 'package:snt_app/Services/auth_service.dart';
import 'package:snt_app/Services/department_service.dart';
import 'package:snt_app/Widgets/General/button.dart';
import 'package:snt_app/Widgets/General/input.dart';
import 'package:snt_app/Widgets/SignUp&LogIn/custom_scaffold.dart';
import 'package:snt_app/Theme/theme.dart';

class YourInfo extends StatefulWidget {
  final String email;
  final String password;
  const YourInfo({super.key, required this.password, required this.email});

  @override
  State<YourInfo> createState() => _YourInfoState();
}

class _YourInfoState extends State<YourInfo> {

  int hoveredIndex = -1;
  bool isRoleOpen = false;
  bool isDepartmentOpen = false;
  late String selectedRole;
  String selectedDepartment = "";
  bool _showUsernameError = false;
  bool _showSkillsError = false;
  bool _showInterestsError = false;
  bool _showDobError = false;

  final List<String> roles = [
    "Member",
    "Manager",
    "Co-Manager",
    "President",
    "Vice president",
    "Secretary general",
    "Other"
  ];

  final department_service = DepartmentService();
  final auth_service = AuthService();

  late Future<List<DepartmentModel>> _departmentsFuture;

  List<String> department_names = [];

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

  void initState() {
    super.initState();
    selectedRole = roles.first;
    _departmentsFuture = department_service.fetchDepartments();
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
              placeholder: 'YYYY-MM-DD',
              controller: dobController,
            ),
            if (_showDobError)
              Text(
                "Enter a valid date of birth following the pattern: YYYY-MM-DD",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: AppColors.Error100,
                ),
              ),
            const SizedBox(height: 10),

            Text(
              "Phone Number (optional)",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: AppColors.Text400,
              ),
            ),
            const SizedBox(height: 6),
            Input(
              prefixIcon: 'lib/Assets/Icons/Call.svg', // add a phone icon to assets
              placeholder: '0512312312',
              controller: phoneController,
              textInputType: TextInputType.number,
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
            FutureBuilder<List<DepartmentModel>>(
              future: _departmentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Loading placeholder
                  return _disabledDropdownPlaceholder("Loading departments...");
                }
                if (snapshot.hasError) {
                  // Error with retry
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _disabledDropdownPlaceholder("Failed to load"),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _departmentsFuture = department_service.fetchDepartments();
                          });
                        },
                        child: Text(
                          "Tap to retry",
                          style: TextStyle(
                            color: AppColors.Error100,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                final departments = snapshot.data ?? [];
                department_names = departments.map((d) => d.name).toList();

                if (department_names.isEmpty) {
                  return _disabledDropdownPlaceholder("No departments available");
                }

                // Ensure selectedDepartment is valid once
                if (selectedDepartment.isEmpty || !department_names.contains(selectedDepartment)) {
                  selectedDepartment = department_names.first;
                }

                return _buildDropdown(
                  icon: 'lib/Assets/Icons/Chart.svg',
                  value: selectedDepartment,
                  items: department_names,
                  isOpen: isDepartmentOpen,
                  onTap: () => setState(() => isDepartmentOpen = !isDepartmentOpen),
                  onSelect: (val) {
                    setState(() {
                      selectedDepartment = val;
                      isDepartmentOpen = false;
                    });
                  },
                );
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
              placeholder: 'e.g., Leadership, UX Design, Photography',
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
              placeholder: 'e.g., Sports, Reading, Taylor Swift,',
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
              onTap: _signup,
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

  void _signup() async {
    setState(() {
      _showUsernameError  = !isValidUsername(usernameController.text);
      _showSkillsError    = !isValidSkills(skillsController.text);
      _showInterestsError = !isValidSkills(interestsController.text);
      _showDobError       = !isValidDateOfBirth(dobController.text);
    });

    if (_showUsernameError || _showSkillsError || _showInterestsError || _showDobError) {
      return; // validation failed
    }

    if (selectedDepartment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a department"))
      );
      return;
    }

    showLoadingDialog(context);

    try {
      await auth_service.setPasswordAndCreateProfile(
        password: widget.password,
        username: usernameController.text,
        skills: parseSkills(skillsController.text),
        interests: parseSkills(interestsController.text),
        departmentName: selectedDepartment,
        dateOfBirth: dobController.text,
        role: selectedRole,
        phoneNumber: phoneController.text, 
      );

      print("profile created");

      await auth_service.signInWithEmailPassword(widget.email, widget.password);

      print("sign in");

      hideLoadingDialog(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
        (Route<dynamic> route) => false,
      );


      print("navigating to home");

    } catch (e) {
      debugPrint("Signup error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to sign up: $e")),
      );
    }
  }


  bool isValidUsername(String username) {
    if (username.isEmpty) return false;
    final regex = RegExp(r'^[a-zA-Z0-9._-]+$');
    return regex.hasMatch(username) && !username.contains(' ');
  }
  bool isValidDateOfBirth(String dob) {
    if (dob.isEmpty) return false;
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(dob)) return false;
    final parts = dob.split('-');
    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) return false;

    try {
      final date = DateTime(year, month, day);
      if (date.day != day || date.month != month || date.year != year) {
        return false;
      }

      return true;
    } catch (_) {
      return false;
    }
  }
  bool isValidSkills(String text) {
    if (text.trim().isEmpty) return false;
    final parts = text.split(',');
    final trimmedParts = parts.map((e) => e.trim()).toList();
    if (trimmedParts.any((p) => p.isEmpty)) return false;
    if (trimmedParts.length < 1) return false;
    return true;
  }

  List<String> parseSkills(String text) {
    return text
        .split(',')
        .map((e) => e.trim())       // remove extra spaces
        .where((e) => e.isNotEmpty) // remove empty entries
        .toList();
  }


  Widget _disabledDropdownPlaceholder(String text) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.Text300, width: 1),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          SvgPicture.asset('lib/Assets/Icons/Chart.svg', width: 20, height: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AppColors.Text300,
              ),
            ),
          ),
          SvgPicture.asset('lib/Assets/Icons/arrowDown_.svg'),
        ],
      ),
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(); 
  }

}
