import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/student/controllers/authentication_controller.dart';
import 'package:prototype/student/models/student_model.dart';
import 'package:prototype/student/views/leave_request.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authenticationController.getUserByRoll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: const Color(0xFF1F2A45), // Matches the profile page's theme
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontFamily: "man-b",
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.mail_outline,
              color: Color.fromARGB(255, 192, 186, 186),
            ),
            onPressed: () {
              // Navigate to the Leave Request Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeaveRequestPage(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Blue background for the top portion
            Container(
              height: MediaQuery.of(context).size.height * 0.48,
              decoration: const BoxDecoration(
                color: Color(0xFF1F2A45), // Blue shade
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 50), // Space for balance

                // Profile circular image
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 58,
                    backgroundImage: AssetImage('images/office_me.jpg'),
                  ),
                ),
                const SizedBox(height: 10),

                // Name and roll number
                Obx(() => authenticationController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Column(
                        children: [
                          Text(
                            "${authenticationController.student.value?.student.firstName ?? 'Loading...'} ${authenticationController.student.value?.student.lastName ?? 'Loading...'} ",
                            style: const TextStyle(
                              fontFamily: "man-b",
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Roll No: ${authenticationController.student.value?.student.rollNo ?? 'N/A'}",
                            style: const TextStyle(
                              fontFamily: "man-r",
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      )),
                const SizedBox(height: 30),

                // White card for attendance and additional info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.38,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            "Attendance",
                            style: TextStyle(
                              fontFamily: "man-b",
                              fontSize: 18,
                              color: Color(0xFF1F2A45),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CircularProgressIndicator(
                                  value: 0.85, // Example: 85% attendance
                                  strokeWidth: 8,
                                  color: const Color(0xFF4CAF50),
                                  backgroundColor: Colors.grey[300],
                                ),
                                const Center(
                                  child: Text(
                                    "85%",
                                    style: const TextStyle(
                                      fontFamily: "man-b",
                                      fontSize: 20,
                                      color: Color(0xFF1F2A45),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // CGPA, Attendance, and Backlogs cards
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _infoCard(
                                  "CGPA",
                                  authenticationController
                                          .student.value?.student.branch
                                          .toString() ??
                                      'N/A',
                                  const Color(0xFF4CAF50)),
                              _infoCard(
                                  "Backlogs",
                                  authenticationController
                                          .student.value?.student.branch
                                          .toString() ??
                                      'N/A',
                                  const Color(0xFFF44336)),
                              _infoCard(
                                  "Attendance",
                                  "${authenticationController.student.value?.student.lastName.toString() ?? 'N/A'}%",
                                  const Color(0xFF2196F3)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Personal Information Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with Edit button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Personal Information",
                            style: TextStyle(
                              fontFamily: "man-b",
                              fontSize: 18,
                              color: Color(0xFF1F2A45),
                            ),
                          ),
                          Column(
                            mainAxisSize:
                                MainAxisSize.min, // Keeps the column compact
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Add edit action here
                                },
                                icon: const Icon(
                                  Icons.edit, // Edit icon
                                  color: Color(0xFF2196F3), // Light blue color
                                  size: 20, // Adjust size if needed
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(
                                    0, -6), // Move the text upward by 6 pixels
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(
                                    fontFamily: "man-l",
                                    fontSize: 12,
                                    color:
                                        Color(0xFF2196F3), // Light blue color
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Detail cards
                      Obx(() => Column(
                            children: [
                              _detailCard(
                                  context,
                                  "Section",
                                  authenticationController
                                          .student.value?.student.section ??
                                      'N/A',
                                  Icons.group),
                              _detailCard(
                                  context,
                                  "Branch",
                                  authenticationController
                                          .student.value?.student.branch ??
                                      'N/A',
                                  Icons.school),
                              _detailCard(
                                  context,
                                  "Email",
                                  authenticationController
                                          .student.value?.student.email ??
                                      'N/A',
                                  Icons.email),
                              _detailCard(
                                  context,
                                  "Phone",
                                  authenticationController
                                          .student.value?.student.phoneNumber ??
                                      'N/A',
                                  Icons.phone),
                              _detailCard(
                                  context,
                                  "Date of Birth",
                                  authenticationController
                                          .student.value?.student.dateOfBirth ??
                                      'N/A',
                                  Icons.calendar_today),
                              _detailCard(
                                  context,
                                  "Year of Study",
                                  authenticationController
                                          .student.value?.student.yearOfStudy
                                          .toString() ??
                                      'N/A',
                                  Icons.book),
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to build the info cards in the white card
  Widget _infoCard(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: "man-sb",
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontFamily: "man-b",
              fontSize: 18,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  // Method to build each detail card
  Widget _detailCard(
      BuildContext context, String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F0F8), // Light blue background
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF1F2A45),
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: "man-sb",
                      fontSize: 14,
                      color: Color(0xFF1F2A45),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontFamily: "man-l",
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
