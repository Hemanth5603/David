import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:prototype/constants.dart';
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

// Controllers for managing data
final StudentNotificationController notificationController =
    Get.put(StudentNotificationController());
final StudentAssignmentController assignmentController =
    Get.put(StudentAssignmentController());
final TimeTableController timeTableController = Get.put(TimeTableController());

class _StudentHomePageState extends State<StudentHomePage> {
  bool _isTableView = false; // Toggle between card and table view

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 236),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            // Header Section
            _buildHeader(),
            // Timetable Section
            _buildTimetableSection(),
            const SizedBox(height: 30),
            // Assignments Section
            _buildAssignmentsSection(),
            const SizedBox(height: 30),
            // Notifications Section
            _buildNotificationsSection(),
          ],
        ),
      ),
    );
  }

  // Header Section
  Widget _buildHeader() {
    return SizedBox(
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
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    "Hemanth Srinivas",
                    style: TextStyle(
                      fontFamily: 'man-l',
                      fontSize: 30,
                      color: Color.fromARGB(255, 31, 31, 31),
                    ),
                  ),
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
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: ClipOval(
              child: Image.asset(
                "images/office_me.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Timetable Section
  Widget _buildTimetableSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Your Schedule",
                style: TextStyle(
                  fontFamily: 'man-sb',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  const Text("", style: TextStyle(fontSize: 16)),
                  Switch(
                    value: _isTableView,
                    onChanged: (value) {
                      setState(() {
                        _isTableView = value;
                      });
                    },
                  ),
                  const Text("Table", style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 190,
          child: Obx(() {
            if (timeTableController.timetable.value == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return _isTableView ? _buildTableView() : _buildCardsView();
          }),
        ),
      ],
    );
  }

  // Assignments Section
  Widget _buildAssignmentsSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/star.png",
                width: 25,
                color: Constants.customOrange,
              ),
              const SizedBox(width: 10),
              const Text(
                "YOUR ASSIGNMENT",
                style: TextStyle(
                  fontSize: 30,
                  color: Constants.customOrange,
                  fontFamily: 'man-b',
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: Obx(() {
            if (assignmentController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
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
            final assignments =
                assignmentController.assignments.value?.assignments ?? [];
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
        ),
      ],
    );
  }

  // Notifications Section
  Widget _buildNotificationsSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/star.png",
                width: 25,
                color: Constants.customOrange,
              ),
              const SizedBox(width: 10),
              const Text(
                "NOTIFICATIONS",
                style: TextStyle(
                  fontFamily: 'man-b',
                  fontSize: 30,
                  color: Constants.customOrange,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 500,
          child: Obx(() {
            final notifications =
                notificationController.notifications.value?.notifications ?? [];
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return notificationCard(
                  MediaQuery.of(context).size.width,
                  notification.title,
                  notification.description,
                  notification.createdAt.split('T')[0],
                  const Color.fromARGB(255, 255, 143, 16),
                  const Color.fromARGB(255, 255, 106, 57),
                  const Color.fromARGB(239, 87, 87, 87),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  // Card View for timetable
  Widget _buildCardsView() {
    final timetables = timeTableController.timetable.value!.timetables[0].classes;
    return CardSwiper(
      cardsCount: timetables.length,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
          timeTableCard(
        timetables[index].teacherName == "" ? "TBD" : timetables[index].teacherName,
        timetables[index].time,
        timetables[index].subjectName,
        timetables[index].room,
      ),
      backCardOffset: const Offset(0, 15),
      numberOfCardsDisplayed: 5,
    );
  }

  // Table View for timetable
  Widget _buildTableView() {
  final timetables = timeTableController.timetable.value?.timetables ?? [];
  if (timetables.isEmpty) {
    return const Center(
      child: Text(
        "No data available",
        style: TextStyle(fontSize: 16, fontFamily: 'man-r'),
      ),
    );
  }
  final todayTimetables = timetables[0].classes;

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0), // Apply margin here
      child: Table(
        border: TableBorder.all(color: Colors.grey, width: 1),
        children: [
          TableRow(
            decoration: const BoxDecoration(color:  Constants.customOrange,),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Time", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Subject", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Room", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Teacher", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          ...todayTimetables.map((classItem) {
            return TableRow(
              decoration: BoxDecoration(
                color: todayTimetables.indexOf(classItem) % 2 == 0
                    ? const Color.fromARGB(255, 244, 244, 244) // Light background for even rows
                    : const Color.fromARGB(255, 243, 230, 211), // White background for odd rows
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(classItem.time),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(classItem.subjectName),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(classItem.room),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    classItem.teacherName.isEmpty ? "TBD" : classItem.teacherName,
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    ),
  );
}
}