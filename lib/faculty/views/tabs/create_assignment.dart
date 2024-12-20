import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:prototype/faculty/controllers/assignment_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAssignmentPage extends StatefulWidget {
  const CreateAssignmentPage({Key? key}) : super(key: key);

  @override
  CreateAssignmentPageState createState() => CreateAssignmentPageState();
}

class CreateAssignmentPageState extends State<CreateAssignmentPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final subjectController = TextEditingController();
  DateTime? _dueDate;
  final AssignmentController assignmentController =
      Get.put(AssignmentController());
  void pickDueDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            dialogBackgroundColor: const Color.fromARGB(255, 35, 37, 49),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }

  void createAssignment() {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        subjectController.text.isEmpty ||
        _dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields to create the assignment"),
        ),
      );
      return;
    }

    // Handle the assignment creation logic here

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 45, 47, 61),
        title: const Text(
          "Assignment Created",
          style: TextStyle(color: Colors.white, fontFamily: 'man-b'),
        ),
        content: Text(
          "Title: ${titleController.text}\n"
          "Description: ${descriptionController.text}\n"
          "Subject: ${subjectController.text}\n"
          "Due Date: ${DateFormat('yyyy-MM-dd').format(_dueDate!)}",
          style: const TextStyle(color: Colors.white70, fontFamily: 'man-r'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK",
                style: TextStyle(color: Colors.white, fontFamily: 'man-sb')),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    subjectController.dispose();
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
            const Text(
              "Enter Assignment Details",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'man-b'),
            ),
            const SizedBox(height: 20),

            // Title Field
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white, fontFamily: 'man-r'),
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle:
                    const TextStyle(color: Colors.white70, fontFamily: 'man-l'),
                filled: true,
                fillColor: const Color.fromARGB(255, 45, 47, 61),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Description Field
            TextField(
              controller: descriptionController,
              style: const TextStyle(color: Colors.white, fontFamily: 'man-r'),
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle:
                    const TextStyle(color: Colors.white70, fontFamily: 'man-l'),
                filled: true,
                fillColor: const Color.fromARGB(255, 45, 47, 61),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Subject Field
            TextField(
              controller: subjectController,
              style: const TextStyle(color: Colors.white, fontFamily: 'man-r'),
              decoration: InputDecoration(
                labelText: 'Subject',
                labelStyle:
                    const TextStyle(color: Colors.white70, fontFamily: 'man-l'),
                filled: true,
                fillColor: const Color.fromARGB(255, 45, 47, 61),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Due Date Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Due Date:",
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, fontFamily: 'man-r'),
                ),
                Text(
                  _dueDate == null
                      ? "Not selected"
                      : DateFormat('yyyy-MM-dd').format(_dueDate!),
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 16, fontFamily: 'man-r'),
                ),
                TextButton(
                  onPressed: pickDueDate,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Select",
                      style: TextStyle(fontFamily: 'man-sb')),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Create Assignment Button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  String branch = prefs.getString("fbranch") ?? 'CSE';
                  String facultyName = prefs.getString("fname") ?? 'John Doe';
                  String facultyId = prefs.getString('fid') ?? "1";
                  String subject = subjectController.text;
                  print(facultyId);
                  print(facultyName);
                  print(subject);
                  assignmentController.createAssignment(
                      title: titleController.text,
                      description: descriptionController.text,
                      facultyId: int.parse(facultyId),
                      facultyName: facultyName,
                      subject: subject,
                      branch: branch,
                      dueDate: _dueDate!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 97, 98, 117),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Create Assignment",
                  style: TextStyle(
                      fontSize: 18, color: Colors.white, fontFamily: 'man-sb'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
