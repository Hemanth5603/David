import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/faculty/controllers/camera_controller.dart';
import 'package:prototype/faculty/views/auth/faculty_face_login_camera.dart';
import 'package:prototype/faculty/views/auth/login.dart';
import 'package:prototype/student/views/auth/student_login.dart';

class OnBoardingPage extends StatelessWidget {
  final Camera camera = Get.put(Camera());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 35, 37, 49), // Dark grayish background
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              // Background with gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 35, 37, 49), // Dark grayish tone
                        Color.fromARGB(255, 255, 153, 98), // Light orange
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              // Main content with larger containers
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
                        title: "Faculty Login -  AI",
                        description: "Manage your classes and lectures",
                        icon: Icons.person,
                        onTap: () {
                          //Get.to(const FacultyLogin());
                          Get.to(FacultyFaceLoginCamera());
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      child: _buildLoginCard(
                        title: "Faculty Login",
                        description: "Manage your classes and lectures",
                        icon: Icons.person,
                        onTap: () {
                          //Get.to(const FacultyLogin());
                          Get.to(FacultyLogin());
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

  // Card widget with larger containers and the new color scheme
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
        margin: EdgeInsets.symmetric(horizontal: 32), // Increased margin
        padding: EdgeInsets.all(24), // Increased padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24), // Larger border radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 20), // Increased shadow offset
              blurRadius: 20, // Increased blur radius
              spreadRadius: 10, // Increased spread radius
            ),
          ],
        ),
        child: Row(
          children: [
            // Left side: Text section with larger font and spacing
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'man-b',
                      fontSize: 32, // Larger font size for title
                      fontWeight: FontWeight.w600, // Bold weight
                      color: Color.fromARGB(255, 255, 153, 98), // Light orange
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'man-l',
                      fontSize: 20, // Larger font size for description
                      color: Color.fromARGB(255, 189, 244, 118), // Soft green
                    ),
                  ),
                ],
              ),
            ),
            // Right side: Icon with rounded background and soft green color
            Container(
              padding: EdgeInsets.all(24), // Increased padding
              decoration: BoxDecoration(
                color:
                    Color.fromARGB(255, 189, 244, 118), // Soft green background
                borderRadius: BorderRadius.circular(16), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(6, 6),
                    blurRadius: 15,
                    spreadRadius: 4,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    offset: Offset(-6, -6),
                    blurRadius: 15,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 56, // Larger icon size
                color: Color.fromARGB(255, 35, 37, 49), // Dark grayish color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
