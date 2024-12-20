import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/faculty/controllers/user_controller.dart';

class FacultyLeaderboard extends StatefulWidget {
  const FacultyLeaderboard({Key? key}) : super(key: key);

  @override
  State<FacultyLeaderboard> createState() => _FacultyLeaderboardState();
}

class _FacultyLeaderboardState extends State<FacultyLeaderboard> {
  final List<Map<String, dynamic>> students = [
    {"rank": 1, "name": "Arun Sharma", "score": 98},
    {"rank": 2, "name": "Neha Gupta", "score": 95},
    {"rank": 3, "name": "Kiran Varma", "score": 90},
    {"rank": 4, "name": "Pooja Rao", "score": 88},
    {"rank": 5, "name": "Madhusudan", "score": 85},
    {"rank": 6, "name": "Sanya Varma", "score": 82},
  ];
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController.getFacultyLeaderBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F2A45),
      appBar: AppBar(
        backgroundColor: Color(0xFF1F2A45),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "LeaderBoard",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'man-b', // Bold Manrope font for title
            color: Color.fromARGB(255, 255, 255, 255),
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
                color: const Color.fromARGB(255, 36, 77, 110),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rank",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'man-sb',
                    ),
                  ),
                  Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'man-sb',
                    ),
                  ),
                  Text(
                    "Score",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'man-sb',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Student List with padding from both sides
          Expanded(
            child: Obx(() {
              if (userController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final metrics =
                  userController.facultyLeaderBoardModel.value?.metrics ?? [];

              if (metrics.isEmpty) {
                return const Center(
                    child: Text('No faculty metrics available'));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: metrics.length,
                  itemBuilder: (context, index) {
                    final faculty = metrics[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 96, 112, 130),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: const Color.fromARGB(255, 168, 165, 165)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Rank Images for top 3 ranks and regular rank numbers for others
                          CircleAvatar(
                            backgroundColor: const Color.fromARGB(0, 95, 88, 88),
                            child: index == 0
                                ? Image.asset('images/first.png',
                                    width: 30, height: 30)
                                : index == 1
                                    ? Image.asset('images/second.png',
                                        width: 30, height: 30)
                                    : index == 2
                                        ? Image.asset('images/third.png',
                                            width: 30, height: 30)
                                        : Text(
                                            '${index + 1}',
                                            style: const TextStyle(
                                              color: Color.fromARGB(255, 241, 239, 239),
                                              fontSize: 18,
                                              fontFamily: 'man-r',
                                            ),
                                          ),
                          ),
                          // Center the name inside the column
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center, // Center alignment
                                children: [
                                  Text(
                                    faculty.facultyName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'man-r',
                                    ),
                                    textAlign: TextAlign.center, // Corrected to use textAlign directly on Text widget
                                  ),
                                  Text(
                                    faculty.department,
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 209, 203, 203),
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center, // Corrected to use textAlign directly on Text widget
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 16,
                            backgroundColor:
                                const Color.fromARGB(255, 155, 170, 182),
                            child: Text(
                              faculty.overallScore.toStringAsFixed(0),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 254, 254),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'man-b',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
