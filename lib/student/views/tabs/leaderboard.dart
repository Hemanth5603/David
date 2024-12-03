import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> students = [
    {"rank": 1, "name": "Rajamahanti Tejaswini", "cgpa": 9.8},
    {"rank": 2, "name": "Jai Jangam", "cgpa": 9.5},
    {"rank": 3, "name": "Priyanka Vemulakonda", "cgpa": 9.0},
    {"rank": 4, "name": "Hemanth Srinivas", "cgpa": 8.8},
    {"rank": 5, "name": "Raghavi Sharon", "cgpa": 8.5},
    {"rank": 6, "name": "Archana Nambi", "cgpa": 8.2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "LeaderBoard",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'man-b', // Bold Manrope font for title
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Circle with leaderboard image
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFFE3F2FD), // Light blue color
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'images/leaderboard.png', // Replace with your leaderboard image
                  width: 60,
                  height: 60,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Table Header with padding from both sides
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Rank",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily:
                          'man-sb', // SemiBold Manrope font for table header
                    ),
                  ),
                  Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily:
                          'man-sb', // SemiBold Manrope font for table header
                    ),
                  ),
                  Text(
                    "CGPA",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily:
                          'man-sb', // SemiBold Manrope font for table header
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Student List with padding from both sides
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 0),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 253, 253, 253),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: const Color.fromARGB(255, 234, 228, 228)!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rank Images for top 3 ranks and regular rank numbers for others
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: student["rank"] == 1
                              ? Image.asset('images/first.png',
                                  width: 30, height: 30)
                              : student["rank"] == 2
                                  ? Image.asset('images/second.png',
                                      width: 30, height: 30)
                                  : student["rank"] == 3
                                      ? Image.asset('images/third.png',
                                          width: 30, height: 30)
                                      : Text(
                                          student["rank"].toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily:
                                                'man-r', // Regular Manrope font for rank
                                          ),
                                        ),
                        ),
                        // Name of the student
                        Text(
                          student["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily:
                                'man-r', // Regular Manrope font for name
                          ),
                        ),
                        // Circle Avatar with Light Blue Color for CGPA
                        CircleAvatar(
                          radius: 16, // Smaller size for CGPA
                          backgroundColor:
                              const Color.fromARGB(255, 209, 232, 249),
                          child: Text(
                            student["cgpa"].toStringAsFixed(1),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 253, 251, 251),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'man-b', // Bold Manrope font for CGPA
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // Footer with "Your Rank"
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Your Rank : ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        'man-sb', // SemiBold Manrope font for "Your Rank"
                  ),
                ),
                Text(
                  "3",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        'man-sb', // SemiBold Manrope font for rank number
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
