import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/faculty/controllers/faculty_attendance_controller.dart';
import 'package:prototype/faculty/controllers/notification_controller.dart';
import 'package:prototype/faculty/views/tabs/faculty_home_page.dart';
import 'package:prototype/faculty/views/utils/error_bottom_sheet.dart';
import 'package:prototype/faculty/views/utils/success_bottom_sheet.dart';
import 'package:prototype/services/auth_service.dart';

class FacultyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final FacultyAttendanceController facultyAttendanceController =
        Get.put(FacultyAttendanceController());
    final NotificationController notificationController =
        Get.put(NotificationController());
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 40, 66),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Blue background for the top portion
            Container(
              height: screenHeight * 0.48,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 6, 7, 42), // Blue shade
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 20),
                // Header section
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      GestureDetector(
                        onTap: () async {
                          String err = await facultyAttendanceController
                              .takeFacultyAttendance();
                          if (err != "") {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ErrorBottomSheet(
                                    error: err,
                                  );
                                });
                          } else {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SuccessBottomSheet(
                                      successMessage: "Attendance Taken",
                                      buttonText: "Go Back",
                                      textColor: Colors.green,
                                      onPressed: () => Get.offAll(
                                          const FacultyHomePage(),
                                          transition: Transition.leftToRight,
                                          duration: 300.milliseconds));
                                });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(15),
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white)),
                          child: const Center(
                            child: Text(
                              "Take Attendance",
                              style: TextStyle(
                                  fontFamily: 'man-r',
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Profile circular image
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('images/faculty_profile.jpeg'),
                  ),
                ),
                const SizedBox(height: 10),
                // Faculty name and ID
                const Text(
                  "Shankar Rao",
                  style: TextStyle(
                    fontFamily: "man-b",
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Faculty ID: FAC21F58",
                  style: TextStyle(
                    fontFamily: "man-l",
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),
                // White card for experience and additional info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: screenHeight * 0.42,
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
                            "Experience",
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
                                  value: 0.75, // Example: 75% experience
                                  strokeWidth: 8,
                                  color: const Color(0xFF4CAF50),
                                  backgroundColor: Colors.grey[300],
                                ),
                                Center(
                                  child: Text(
                                    "15 yrs",
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
                          const SizedBox(height: 60),
                          // Info cards for Qualification, Subjects, and Office Hours
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _infoCard("Qualification", "Ph.D.",
                                  const Color(0xFF4CAF50)),
                              _infoCard(
                                  "Subjects", "3", const Color(0xFF2196F3)),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Personal Information",
                            style: TextStyle(
                              fontFamily: "man-b",
                              fontSize: 18,
                              color: Color.fromARGB(255, 241, 242, 244),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Add edit action here
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Color(0xFF2196F3),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _detailCard(context, "Qualification",
                          "Ph.D. in Computer Science", Icons.school),
                      _detailCard(context, "Subjects Dealing",
                          "AI, ML, and IoT", Icons.subject),
                      _detailCard(context, "Email",
                          "sarah.williams@university.com", Icons.email),
                      _detailCard(
                          context, "Phone", "+91 9876543210", Icons.phone),
                      _detailCard(context, "Department",
                          "Computer Science Engineering", Icons.business),
                      _detailCard(context, "Office Location",
                          "Room 204, Block A", Icons.location_on),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () async {
                      print("Sent ALert");
                      await notificationController.sendAlert();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 74, 74),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.notification_important,
                              color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Alert !!",
                            style: TextStyle(
                              fontFamily: "man-sb",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Logout card at the bottom
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      AuthService().logout();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F0F8),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.logout, color: Color(0xFF1F2A45)),
                          SizedBox(width: 10),
                          Text(
                            "Logout",
                            style: TextStyle(
                              fontFamily: "man-sb",
                              fontSize: 16,
                              color: Color(0xFF1F2A45),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontFamily: "man-b",
                      fontSize: 16,
                      color: Colors.black,
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
