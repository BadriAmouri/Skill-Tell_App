import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(child: QRProfileCard()),
      ),
    );
  }
}

class QRProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 580,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('lib/assetss/splash.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          // Logo
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/Assets/Images/logo.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // QR Code with decorative lines
          Stack(
            alignment: Alignment.center,
            children: [
              // Horizontal lines
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 1, width: 40, color: Colors.white),
                  const SizedBox(width: 15),
                  Container(height: 1, width: 40, color: Colors.white),
                ],
              ),
              // Vertical lines
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 40, width: 1, color: Colors.white),
                  const SizedBox(height: 15),
                  Container(height: 40, width: 1, color: Colors.white),
                ],
              ),
              // QR Code
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: QrImageView(
                    data: 'https://example.com',
                    version: QrVersions.auto,
                    size: 200,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // Text content with local Poppins
          const SizedBox(height: 25),
          Column(
            children: [
              Text(
                '-Scan me-',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  shadows: const [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Gmail indicator using Flutter's built-in icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.mail, color: Colors.white, size: 20),
                  const SizedBox(width: 5),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
