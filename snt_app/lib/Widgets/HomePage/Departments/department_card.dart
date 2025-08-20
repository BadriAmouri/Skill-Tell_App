import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snt_app/Models/department_model.dart';
import 'package:snt_app/Screens/Home/department_members.dart';
import 'package:snt_app/Theme/theme.dart';

class DepartmentCard extends StatelessWidget {
  final DepartmentModel department;

  const DepartmentCard({Key? key, required this.department}) : super(key: key);

  void onTap(String department_name, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (e) => DepartmentMembers(department_name: department_name,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = 220;
    final double cardHeight = 220;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onTap(department.name, context);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: cardWidth,
          height: cardHeight,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: AppColors.Neutral200, // border color
              width: 1, // border width
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                blurRadius: 4,
                offset: const Offset(2, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              spacing: 10,
              children: [
        
                Container(
                  height: 143,
                  decoration: BoxDecoration(
                    color: AppColors.Main600,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: department.imageUrl != null
                          ? NetworkImage(department.imageUrl!)
                          : const AssetImage('lib/Assets/Images/badri.jpg') as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        
        
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 12,
                  children: [
                    Text(
                      "${department.name} Department",
                      style: TextStyle(
                        fontFamily: AppFonts.primaryFontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: AppColors.Main600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Discover the department",
                          style: TextStyle(
                            fontFamily: AppFonts.primaryFontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 8,
                            color: AppColors.Accent400,
                          ),
                        ),
                        SvgPicture.asset(
                          'lib/Assets/Icons/ArrowUp.svg',
                          color: AppColors.Accent400,  // optional, applies tint
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),  
        
                  ],
                )
            
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
