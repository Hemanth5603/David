import 'package:flutter/material.dart';

class StudentProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Blue background for the top portion
            Container(
              height: screenHeight * 0.48,
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
                    radius: 55,
                    backgroundImage: AssetImage('assets/preson.png'),
                  ),
                ),
                const SizedBox(height: 10),

                // Name and roll number
                const Text(
                  "Caroline",
                  style: TextStyle(
                    fontFamily: "man-b",
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Roll No: 213J1A04C6",
                  style: TextStyle(
                    fontFamily: "man-l",
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),

                // White card for attendance and additional info
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
                          const SizedBox(height: 60),

                          // CGPA, Attendance, and Backlogs cards
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _infoCard("CGPA", "8.5", const Color(0xFF4CAF50)),
                              _infoCard("Backlogs", "0", const Color(0xFFF44336)),
                              _infoCard("Attendance", "85%", const Color(0xFF2196F3)),
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
                            mainAxisSize: MainAxisSize.min, // Keeps the column compact
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
                                offset: const Offset(0, -6), // Move the text upward by 6 pixels
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(
                                    fontFamily: "man-l",
                                    fontSize: 12,
                                    color: Color(0xFF2196F3), // Light blue color
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),

                      const SizedBox(height: 10),

                      // Detail cards
                      _detailCard(context, "Section", "B", Icons.group),
                      _detailCard(context, "Branch", "Computer Science Engineering", Icons.school),
                      _detailCard(context, "Email", "Ishithacaroline@gmail.com", Icons.email),
                      _detailCard(context, "Phone", "+91 9876543210", Icons.phone),
                      _detailCard(context, "Date of Birth", "01 Jan 2003", Icons.calendar_today),
                      _detailCard(context, "Year of Study", "3rd Year", Icons.book),
                      
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
  Widget _detailCard(BuildContext context, String title, String value, IconData icon) {
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
