import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/faculty/views/auth/faculty_face_login_camera.dart';
import 'package:prototype/faculty/views/auth/login.dart';
import 'package:prototype/student/views/auth/student_login.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              // Background with gradient and a subtle blur
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFD4A3), // Warm Autumn
                        Color(0xFFFFE5D0), // Soft Peach
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
              // Main content: Login cards
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Header section
                    Padding(
                      padding: EdgeInsets.only(bottom: 40.0),
                      child: Text(
                        "Welcome, Please Login",
                        style: TextStyle(
                          fontFamily: 'man-b',
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8C4F0A),
                        ),
                      ),
                    ),
                    // Student Login Card
                    _buildLoginCard(
                      title: "Student Login",
                      description: "Access your student dashboard",
                      icon: Icons.school,
                      onTap: () {
                        Get.to(StudentLogin());
                      },
                    ),
                    const SizedBox(height: 24),
                    // Faculty Login Card
                    _buildLoginCard(
                      title: "AI Camera Login ✨",
                      description: "Manage your classes and lectures",
                      icon: Icons.person,
                      onTap: () {
                        Get.to(FacultyFaceLoginCamera());
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildLoginCard(
                      title: "Faculty Login",
                      description: "Manage your classes and lectures",
                      icon: Icons.person,
                      onTap: () {
                        Get.to(FacultyLogin());
                      },
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

  // Card widget with subtle hover effect and gradient background
  Widget _buildLoginCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFD4A3),
              Color(0xFFFFE5D0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0, 10),
              blurRadius: 20,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          children: [
            // Text section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'man-b',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8C4F0A),
                    ),
                  ),
                  const SizedBox(height: 8),
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
            // Icon with gradient background
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFD4A3),
                    Color(0xFFFFE5D0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(4, 4),
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.6),
                    offset: Offset(-4, -4),
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ],
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
