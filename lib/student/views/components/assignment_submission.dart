import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:prototype/faculty/controllers/assignment_controller.dart';
import 'package:prototype/student/controllers/assignment_controller.dart';
import 'package:prototype/student/models/student_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignmentSubmissionPage extends StatefulWidget {
  const AssignmentSubmissionPage({super.key});

  @override
  _AssignmentSubmissionPageState createState() =>
      _AssignmentSubmissionPageState();
}

class _AssignmentSubmissionPageState extends State<AssignmentSubmissionPage> {
  final _sectionController = TextEditingController();
  final _rollNumberController = TextEditingController();
  late DateTime _selectedDate;
  String? _fileName;
  final StudentAssignmentController assignmentController =
      Get.put(StudentAssignmentController());

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now(); // Initialize with the current date
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Allow only PDF files
    );
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name; // Store the file name
      });
    }
  }

  void _submitAssignment() async {
    if (_sectionController.text.isEmpty ||
        _rollNumberController.text.isEmpty ||
        _fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill all fields and select a file")),
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // final success = await assignmentController.submitAssignment(
      //   studentId: prefs.getString("id")!,
      //   studentName: prefs.getString("name")!,
      //   branch: prefs.getString("branch")!,
      //   subjectName: prefs.getString("subject")!,
      //   assignmentTitle: _titleController.text,
      //   pdfPath: _fileName!,
      // );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Assignment Submitted"),
        content: Text(
          "Section: ${_sectionController.text}\n"
          "Roll Number: ${_rollNumberController.text}\n"
          "File: $_fileName\n"
          "Submitted on: ${DateFormat('yyyy-MM-dd – kk:mm').format(_selectedDate)}",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _sectionController.dispose();
    _rollNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Assignment Submission",
          style: TextStyle(fontFamily: 'man-b', fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 247, 254, 252),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 247, 254, 252),
              Color.fromARGB(255, 251, 255, 255)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Submit Your Assignment",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 23, 92, 101),
                  fontFamily: 'man-sb',
                ),
              ),
              const SizedBox(height: 20),

              // Section Field
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _sectionController,
                  style:
                      const TextStyle(color: Colors.black, fontFamily: 'man-r'),
                  decoration: InputDecoration(
                    labelText: 'Section',
                    labelStyle: const TextStyle(
                        color: Color(0xFF135D66), fontFamily: 'man-l'),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Roll Number Field
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _rollNumberController,
                  style:
                      const TextStyle(color: Colors.black, fontFamily: 'man-r'),
                  decoration: InputDecoration(
                    labelText: 'Roll Number',
                    labelStyle: const TextStyle(
                        color: Color(0xFF135D66), fontFamily: 'man-l'),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Pick File Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _pickFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 107, 163, 170),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Choose PDF File",
                    style: TextStyle(
                        fontFamily: 'man-b', fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              if (_fileName != null) ...[
                const SizedBox(height: 10),
                Text(
                  "Selected File: $_fileName",
                  style: const TextStyle(
                      color: Color(0xFF135D66), fontFamily: 'man-r'),
                ),
              ],
              const SizedBox(height: 20),

              // Submission Date Picker
              Row(
                children: [
                  const Text(
                    "Submission Date: ",
                    style: TextStyle(
                        color: Color(0xFF135D66), fontFamily: 'man-r'),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd').format(_selectedDate),
                    style: const TextStyle(
                        color: Color(0xFF135D66), fontFamily: 'man-r'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today,
                        color: Color(0xFF135D66)),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != _selectedDate) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                ],
              ),
              const Spacer(),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitAssignment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 100, 151, 158),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Submit Assignment",
                    style: TextStyle(
                        fontFamily: 'man-b', fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
