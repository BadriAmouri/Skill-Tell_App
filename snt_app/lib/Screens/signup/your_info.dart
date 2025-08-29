import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snt_app/Screens/Home/home_screen.dart';
import 'package:snt_app/Widgets/General/button.dart';
import 'package:snt_app/Widgets/General/input.dart';
import 'package:snt_app/Widgets/SignUp&LogIn/custom_scaffold.dart';
import 'package:snt_app/Theme/theme.dart';

class YourInfo extends StatefulWidget{
  const YourInfo({super.key});

  @override
  State<YourInfo> createState() => _YourInfoState();
}
class _YourInfoState extends State<YourInfo>{
  double topValue = 340;
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
  final List<String>departments = [
    "UI/UX department",
    "Graphic design department",
    "Marketing department",
    "Logistics department",
    "Production department",
    "Sponsoring department",
    "Media department",
    "Communication department",
    "HR department",
    "AI department",
    "Relax department",
    "Dev department",
    "Planning department",
    "Event department"
  ];
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  @override
  void dispose(){
    usernameController.dispose();
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
      child: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 10,
                left: 29,
                right: 29,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          'lib/Assets/Icons/arrowLeft_.svg', 
                          width: 25,
                          height: 25,
                        ),
                      ),
                      const SizedBox(width: 80,),
                      Text(
                        "Your info",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          color: AppColors.Text500,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
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
                  const SizedBox(height: 8),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Username",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: AppColors.Text400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Input(
                            prefixIcon: 'lib/Assets/Icons/profile_.svg', 
                            placeholder: 'Username',
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
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Role",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: AppColors.Text400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        InkWell(
                          onTap: () => setState(() => isRoleOpen = !isRoleOpen),
                          child: Container(
                            width: double.infinity,
                            height: 44,
                            padding: const EdgeInsets.only(left: 27, right: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColors.Text300),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset('lib/Assets/Icons/member_.svg', width: 20, height: 20),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    selectedRole,
                                    style: const TextStyle(
                                      color: AppColors.Text300,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                AnimatedRotation(
                                  turns: isRoleOpen ? 0.25 : 0.0,
                                  duration: const Duration(milliseconds: 100),
                                  child: SvgPicture.asset('lib/Assets/Icons/arrowDown_.svg'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isRoleOpen)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(22),
                                bottomRight: Radius.circular(22),
                              ),
                              border: const Border(
                                bottom: BorderSide(color: AppColors.Text300),
                                left: BorderSide(color: AppColors.Text300),
                                right: BorderSide(color: AppColors.Text300),
                              ),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height * 0.1,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: roles.length,
                                itemBuilder: (context, index) {
                                  final item = roles[index];
                                  return MouseRegion(
                                    onEnter: (_) => setState(() => hoveredIndex = index),
                                    onExit: (_) => setState(() => hoveredIndex = -1),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedRole = item;
                                          isRoleOpen = false;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 57),
                                        alignment: Alignment.centerLeft,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: hoveredIndex == index
                                              ? Colors.grey.shade100
                                              : Colors.transparent,
                                          border: index != roles.length - 1
                                              ? const Border(
                                                  bottom: BorderSide(
                                                    color: AppColors.Text300,
                                                    width: 0.6,
                                                  ),
                                                )
                                              : null,
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
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Department",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: AppColors.Text400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        InkWell(
                          onTap: () => setState(() => isDepartmentOpen = !isDepartmentOpen),
                          child: Container(
                            width: double.infinity,
                            height: 44,
                            padding: const EdgeInsets.only(left: 27, right: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColors.Text300),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset('lib/Assets/Icons/department_.svg', width: 20, height: 20),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    selectedDepartment,
                                    style: const TextStyle(
                                      color: AppColors.Text300,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                AnimatedRotation(
                                  turns: isDepartmentOpen ? 0.25 : 0.0,
                                  duration: const Duration(milliseconds: 100),
                                  child: SvgPicture.asset('lib/Assets/Icons/arrowDown_.svg'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isDepartmentOpen)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(22),
                                bottomRight: Radius.circular(22),
                              ),
                              border: const Border(
                                bottom: BorderSide(color: AppColors.Text300),
                                left: BorderSide(color: AppColors.Text300),
                                right: BorderSide(color: AppColors.Text300),
                              ),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height * 0.1,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: departments.length,
                                itemBuilder: (context, index) {
                                  final item = departments[index];
                                  return MouseRegion(
                                    onEnter: (_) => setState(() => hoveredIndex = index),
                                    onExit: (_) => setState(() => hoveredIndex = -1),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedDepartment = item;
                                          isDepartmentOpen = false;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 57),
                                        alignment: Alignment.centerLeft,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: hoveredIndex == index
                                              ? Colors.grey.shade100
                                              : Colors.transparent,
                                          border: index != departments.length - 1
                                              ? const Border(
                                                  bottom: BorderSide(
                                                    color: AppColors.Text300,
                                                    width: 0.6,
                                                  ),
                                                )
                                              : null,
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
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Skills and Interests",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: AppColors.Text400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Input(
                            prefixIcon: 'lib/Assets/Icons/skills_.svg', 
                            placeholder: 'e.g., Leadership, UX Design, Basketball, Reading',
                            controller: skillsController,
                          ),
                          if (_showSkillsError)
                            Text(
                              "this field is required",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: AppColors.Error100,
                              ),
                            ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 30,),
                  Button(
                      onTap: () {
                        setState(() {
                          _showUsernameError = usernameController.text.isEmpty;
                          _showSkillsError = skillsController.text.isEmpty;
                        });
              
                        if (!_showUsernameError && !_showSkillsError) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (e) => HomeScreen()),
                          );
                        } 
                      },
                      buttonText: "Sign up"
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            
            const SizedBox(height: 8),
          ], 
        ),
      ),
    );
  }
}