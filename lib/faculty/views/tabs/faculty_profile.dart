import 'package:flutter/material.dart';

class FacultyProfilePage extends StatelessWidget {
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
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/faculty.png'),
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
                              _infoCard("Qualification", "Ph.D.", const Color(0xFF4CAF50)),
                              _infoCard("Subjects", "3", const Color(0xFF2196F3)),
                              //_infoCard("Office Hours", "10AM-4PM", const Color(0xFFF44336)),
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
                      _detailCard(context, "Qualification", "Ph.D. in Computer Science", Icons.school),
                      _detailCard(context, "Subjects Dealing", "AI, ML, and IoT", Icons.subject),                      
                      _detailCard(context, "Email", "sarah.williams@university.com", Icons.email),
                      _detailCard(context, "Phone", "+91 9876543210", Icons.phone),
                      _detailCard(context, "Department", "Computer Science Engineering", Icons.business),
                      _detailCard(context, "Office Location", "Room 204, Block A", Icons.location_on),
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
