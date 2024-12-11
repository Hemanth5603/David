import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/constants.dart';
import 'package:prototype/faculty/controllers/find_face_controller.dart';
import 'package:prototype/faculty/controllers/notification_controller.dart';
import 'package:prototype/student/controllers/assignment_controller.dart';
import 'package:prototype/student/controllers/notification_controller.dart';
import 'package:prototype/student/controllers/timetable_controller.dart';
import 'package:prototype/student/views/components/assignment_card.dart';
import 'package:prototype/student/views/components/notification_card.dart';
import 'package:prototype/student/views/components/time_table_card.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

final StudentNotificationController notificationController =
    Get.put(StudentNotificationController());
final StudentAssignmentController assignmentController =
    Get.put(StudentAssignmentController());

final TimeTableController timeTableController = Get.put(TimeTableController());

final class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 236),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 130,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 90,
                      height: 80,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello 👋",
                            style: TextStyle(
                                fontFamily: 'man-b',
                                fontSize: 25,
                                color: Color.fromARGB(255, 36, 36, 36),
                                letterSpacing: 1),
                          ),
                          Text(
                            "Hemanth Srinivas",
                            style: TextStyle(
                                fontFamily: 'man-l',
                                fontSize: 30,
                                color: Color.fromARGB(255, 31, 31, 31)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 1)),
                    child: ClipOval(
                      child: Image.asset(
                        "images/office_me.jpg",
                        fit: BoxFit.cover, // Ensures the image fills the circle
                      ),
                    ),
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 600,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 252, 255, 249),
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /*Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color.fromARGB(
                                          255, 255, 232, 169)),
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/icons/leaf.png",
                                      fit: BoxFit
                                          .cover, // Ensures the image fills the circle
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "AQI",
                                  style: TextStyle(
                                      fontFamily: 'man-r',
                                      fontSize: 25,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            Text(
                              "1120",
                              style: TextStyle(
                                  fontFamily: 'man-b',
                                  fontSize: 25,
                                  color:
                                      const Color.fromARGB(255, 244, 193, 54)),
                            ),*/
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0, top: 0),
                        child: Text(
                          "Your Schedule",
                          style: TextStyle(
                              fontFamily: 'man-sb',
                              fontSize: 25,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 190,
                        child: Obx(() {
                          if (timeTableController.timetable.value == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final timetables = timeTableController
                              .timetable.value!.timetables[0].classes;
                          return CardSwiper(
                            cardsCount: timetables.length,
                            cardBuilder: (context, index, percentThresholdX,
                                    percentThresholdY) =>
                                timeTableCard(
                              timetables[index].teacherName == ""
                                  ? "Dr.Sahu"
                                  : timetables[index].teacherName,
                              timetables[index].time,
                              timetables[index].subjectName,
                              timetables[index].room,
                            ),
                            backCardOffset: const Offset(0, 15),
                            numberOfCardsDisplayed: 5,
                          );
                        }),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 300,
                  left: 15,
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/star.png",
                        width: 25,
                        color: Constants.customOrange,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "YOUR ASSIGNMENT",
                        style: TextStyle(
                            fontSize: 30,
                            color: Constants.customOrange,
                            fontFamily: 'man-b'),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 380,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      child: Obx(() {
                        if (assignmentController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (assignmentController.error.value.isNotEmpty) {
                          return Center(
                            child: Text(
                              assignmentController.error.value,
                              style: const TextStyle(
                                color: Colors.red,
                                fontFamily: 'man-r',
                              ),
                            ),
                          );
                        }

                        final assignments = assignmentController
                                .assignments.value?.assignments ??
                            [];

                        if (assignments.isEmpty) {
                          return const Center(
                            child: Text(
                              'No assignments available',
                              style: TextStyle(
                                fontFamily: 'man-r',
                                fontSize: 16,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: assignments.length,
                          itemBuilder: (context, index) {
                            final assignment = assignments[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: assignmentCard(
                                MediaQuery.of(context).size.width,
                                assignment.facultyName,
                                assignment.title,
                                assignment.description,
                                assignment.subject,
                                assignment.dueDate.toString().substring(0, 10),
                              ),
                            );
                          },
                        );
                      }),
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/star.png",
                    width: 25,
                    color: Constants.customOrange,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "NOTIFICATIONS",
                    style: TextStyle(
                        fontFamily: 'man-b',
                        fontSize: 30,
                        color: Constants.customOrange),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: Obx(() {
                final notifications =
                    notificationController.notifications.value?.notifications ??
                        [];
                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return notificationCard(
                        MediaQuery.of(context).size.width,
                        notification.title,
                        notification.description,
                        notification.createdAt.split('T')[0],
                        Color.fromARGB(255, 255, 143, 16),
                        Color.fromARGB(255, 255, 106, 57),
                        Color.fromARGB(239, 87, 87, 87));
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
