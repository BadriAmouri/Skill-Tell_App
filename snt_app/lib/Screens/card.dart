import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(child: RotatedBox(quarterTurns: 1, child: MemberCard())),
      ),
    ),
  );
}

class MemberCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 230,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 4)),
        ],
      ),
      child: Column(
        children: [
          // Main content area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Header with logo, title and QR code
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("lib/Assets/Images/logo.png", width: 50),
                      Text(
                        "Member card",
                        style: TextStyle(
                          fontFamily: 'Poppins',
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

                  SizedBox(height: 12),

                  // Member information
                  Expanded(
                    child: Row(
                      children: [
                        // Profile Image Placeholder
                        Container(
                          width: 80,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey[700],
                          ),
                        ),

                        SizedBox(width: 16),

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
            decoration: BoxDecoration(
              color: Colors.purple[800],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Container(
          width: 100, // Fixed width for labels
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
