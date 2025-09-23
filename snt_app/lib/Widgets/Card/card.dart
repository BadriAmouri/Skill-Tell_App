import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:snt_app/Theme/theme.dart';

class MemberCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.VERTICAL, 
      front: _buildFrontCard(),
      back: _buildBackCard(),
    );
  }

  Widget _buildFrontCard() {
    
    return Container(
      height: 320,
      width: 550,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.11),
            blurRadius: 40.4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],

      ),
      child: Column(
        children: [
          // Main content area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 25, left: 25, top: 5, bottom: 25),
              child: Column(
                children: [
                  // Header with logo, title and QR code
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("lib/Assets/Images/logoclub-2.png", width: 50,),
                      Text(
                        "Member card",
                        style: TextStyle(
                          fontFamily: AppFonts.primaryFontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.purple[800],
                        ),
                      ),
                      QrImageView(
                        data: "LING 123456789",
                        version: QrVersions.auto,
                        size: 50,
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Member information
                  Expanded(
                    child: Row(
                      spacing: 16,
                      children: [
                        // Profile Image Placeholder
                        Container(
                          width: 200,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(217, 217, 217, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),

                        // Info
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow("Name", "Full name"),
                              _buildInfoRow("Email", "Email@email.com"),
                              _buildInfoRow("Phone number", "06/03/2025"),
                              _buildInfoRow("Date of birth", "05/06/2025"),
                              _buildInfoRow("School", "ENGLY27"),
                              _buildInfoRow("Department", "HRManager"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Purple footer bar
          Container(
            height: 24,
            width: 550,
            decoration: BoxDecoration(
              color: Colors.purple[800],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage("lib/Assets/Images/Slide16_9-5.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ID NO: 1234567890",
                  style: TextStyle(
                    fontFamily: AppFonts.primaryFontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.White,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
            label,
            style: TextStyle(
              fontFamily: AppFonts.primaryFontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.Neutral400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: AppFonts.primaryFontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.Neutral300,
            ),
          ),
      ],
    );
  }

  Widget _buildBackCard() {
    return Container(
      height: 320,
      width: 550,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage("lib/Assets/Images/state=off.png"),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.11),
            blurRadius: 40.4,
            offset: Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
