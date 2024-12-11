import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/faculty/views/auth/faculty_face_login_camera.dart';
import 'package:prototype/faculty/views/auth/login.dart';
import 'package:prototype/student/views/auth/student_login.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color is white
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              // Background Layer: Painted or Textured effect
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFD4A3), // Warm Autumn
                        Color(0xFFFFE5D0), // Soft Peach
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/paint_texture.png'), // Abstract paint texture
                      fit: BoxFit.cover,
                      opacity:
                          0.15, // Subtle texture to not distract from the content
                    ),
                  ),
                ),
              ),
              // Main Content: Cards and text
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Header Section
                    const Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Text(
                        "Welcome, Please Login",
                        style: TextStyle(
                          fontFamily: 'man-b',
                          fontSize: 28,
                          color: Color(0xFF8C4F0A), // Autumn shade
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Student Login Card
                    GestureDetector(
                      child: _buildLoginCard(
                        title: "Student Login",
                        description: "Access your student dashboard",
                        icon: Icons.school,
                        onTap: () {
                          Get.to(StudentLogin());
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Faculty Login Card
                    GestureDetector(
                      child: _buildLoginCard(
                        title: "Faculty Login",
                        description: "Manage your classes and lectures",
                        icon: Icons.person,
                        onTap: () {
                          Get.to(const FacultyLogin());
                          //Get.to(FacultyFaceLoginAICamera());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Card widget to display the login card
  Widget _buildLoginCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            // Left side: Text section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'man-b',
                      fontSize: 22,
                      color: Color(0xFF8C4F0A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'man-l',
                      fontSize: 16,
                      color: Color(0xFF6E4E2E),
                    ),
                  ),
                ],
              ),
            ),
            // Right side: Icon
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFFD4A3), // Autumn color
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 40,
                color: Color(0xFF8C4F0A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}