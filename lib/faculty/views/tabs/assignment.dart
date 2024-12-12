import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:prototype/faculty/controllers/assignment_controller.dart';
import 'package:prototype/faculty/views/components/assignment_card.dart';
import 'package:prototype/faculty/views/tabs/create_assignment.dart';
import 'package:prototype/student/views/components/assignment_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignmentPage extends StatefulWidget {
  AssignmentPage({Key? key}) : super(key: key);

  AssignmentController assignmentController = Get.put(AssignmentController());

  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subjectController = TextEditingController();
  DateTime? _dueDate;
  final AssignmentController assignmentController =
      Get.put(AssignmentController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignmentController.getAssignmentSubmissions();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Assignment",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontFamily: 'man-b')),
        backgroundColor: const Color.fromARGB(255, 35, 37, 49),
      ),
      backgroundColor: const Color.fromARGB(255, 35, 37, 49),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.to(
                  transition: Transition.rightToLeft,
                  duration: 300.milliseconds,
                  CreateAssignmentPage()),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 130,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 254, 165, 118),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create New Assignment",
                        style: TextStyle(
                            fontFamily: 'man-sb',
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(125, 255, 255, 255)),
                            child: Center(
                              child: Text(
                                "DBMS",
                                style: TextStyle(
                                    fontFamily: 'man-l',
                                    fontSize: 12,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(125, 255, 255, 255)),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/arrow.png',
                                width: 20,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Assignment Submissions",
              style: TextStyle(
                  fontFamily: 'man-sb', fontSize: 18, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 480,
              child: Obx(
                () => assignmentController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : assignmentController
                            .submissions.value!.submissions.isEmpty
                        ? Center(
                            child: Text(
                              'No submissions yet',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'man-r',
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: assignmentController
                                .submissions.value!.submissions.length,
                            itemBuilder: (context, index) {
                              return AssignmentSubmittedCard(
                                MediaQuery.of(context).size.width,
                                assignmentController.submissions.value!
                                    .submissions[index].studentName,
                                assignmentController.submissions.value!
                                    .submissions[index].branch,
                                assignmentController.submissions.value!
                                    .submissions[index].subjectName,
                                assignmentController.submissions.value!
                                    .submissions[index].submissionDate,
                                pdfUrl: assignmentController.submissions.value!
                                    .submissions[index].pdfUrl,
                              );
                            },
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
