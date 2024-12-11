import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/faculty/controllers/user_controller.dart';
import 'package:prototype/student/controllers/leaderboard_controller.dart';

class StudentLeaderboard extends StatefulWidget {
  StudentLeaderboard({Key? key}) : super(key: key);

  @override
  State<StudentLeaderboard> createState() => _StudentLeaderboardState();
}

class _StudentLeaderboardState extends State<StudentLeaderboard> {
  final LeaderboardController leaderboardController =
      Get.put(LeaderboardController());

  @override
  void initState() {
    super.initState();
    leaderboardController.getStudentLeaderBoard();
  }

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
              if (leaderboardController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final metrics =
                  leaderboardController.studentLeaderboard.value?.data ?? [];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: leaderboardController
                      .studentLeaderboard.value?.data.rankings.length,
                  itemBuilder: (context, index) {
                    final faculty = leaderboardController
                        .studentLeaderboard.value?.data.rankings[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 253, 253, 253),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: const Color.fromARGB(255, 234, 228, 228)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Rank Images for top 3 ranks and regular rank numbers for others
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
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
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'man-r',
                                            ),
                                          ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center, // Center alignment
                                children: [
                                  Text(
                                    "${faculty!.firstName} ${faculty.lastName}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'man-r',
                                    ),
                                    textAlign: TextAlign.center, // Corrected to use textAlign directly on Text widget
                                  ),
                                  Text(
                                    faculty.branch,
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.grey[600],
                                      fontSize: 12,
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
                                const Color.fromARGB(255, 209, 232, 249),
                            child: Center(
                              child: Text(
                                faculty.cgpa.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 254, 254),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'man-b',
                                ),
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
