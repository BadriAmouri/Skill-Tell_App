import 'package:flutter/material.dart';
import 'package:snt_app/Models/user_model.dart';
import 'package:snt_app/Theme/theme.dart';




class DepartmentMemberCard extends StatelessWidget {

  final UserModel user;

  const DepartmentMemberCard({Key? key, required this.user}) : super(key: key);

  static BoxDecoration ManagerCardBoxDecoration = BoxDecoration(
    color: AppColors.Main100,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: const Color.fromRGBO(0, 0, 0, 0.08),
        offset: const Offset(2, 2),
        blurRadius: 4,
        spreadRadius: 0,
      ),
    ],
  );
  static BoxDecoration CoManagerCardBoxDecoration = BoxDecoration(
    color: const Color.fromARGB(255, 255, 240, 229),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: const Color.fromRGBO(0, 0, 0, 0.08),
        offset: const Offset(2, 2),
        blurRadius: 4,
        spreadRadius: 0,
      ),
    ],
  );
  static BoxDecoration MemberCardBoxDecoration = BoxDecoration(
    color: AppColors.White,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: const Color.fromRGBO(0, 0, 0, 0.08),
        offset: const Offset(2, 2),
        blurRadius: 4,
        spreadRadius: 0,
      ),
    ],
  );


  static  BoxDecoration ManagerCardBorder = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      width: 1,
      color: Colors.transparent, // Required for gradient border
    ),
    gradient: const LinearGradient(
      colors: [
        Color.fromRGBO(123, 44, 191, 1),
        Color.fromRGBO(123, 44, 191, 0.1),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
  static BoxDecoration CoManagerCardBorder = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      width: 1,
      color: Colors.transparent, // Required for gradient border
    ),
    gradient: const LinearGradient(
      colors: [
        Color.fromRGBO(255, 109, 0, 1),
        Color.fromRGBO(255, 109, 0, 0.1),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
  static BoxDecoration MemberCardBorder = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      width: 1,
      color: AppColors.Neutral200, // Required for gradient border
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(10),
      decoration: user.role.toLowerCase() == "manager"? ManagerCardBorder
                  : user.role.toLowerCase() == "co-manager"? CoManagerCardBorder
                  : MemberCardBorder,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: user.role.toLowerCase() == "manager"? ManagerCardBoxDecoration
                  : user.role.toLowerCase() == "co-manager"? CoManagerCardBoxDecoration
                  : MemberCardBoxDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [

            user.pfp != null && user.pfp!.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(user.pfp!),
                radius: 30,
              )
            : CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.Main300
              ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.username,
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, fontFamily: AppFonts.primaryFontFamily,),
                ),
                Text(
                  user.role,
                  style: const TextStyle(fontSize: 10, color: Color.fromRGBO(0,0,0,0.5), fontFamily: AppFonts.primaryFontFamily,),
                ),
              ],
            )

          ],
        )
      ),
    );
  }
}
