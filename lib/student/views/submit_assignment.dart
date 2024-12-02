import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // For file picking (PDF)
import 'package:intl/intl.dart'; // For date formatting

class AssignmentSubmissionPage extends StatefulWidget {
  const AssignmentSubmissionPage({super.key});

  @override
  _AssignmentSubmissionPageState createState() =>
      _AssignmentSubmissionPageState();
}

class _AssignmentSubmissionPageState extends State<AssignmentSubmissionPage> {
  final _subjectController = TextEditingController();
  final _facultyController = TextEditingController();
  late DateTime _selectedDate;
  String? _fileName;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now(); // Initialize with the current date
  }

  // Function to pick PDF file
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

  // Function to handle assignment submission
  void _submitAssignment() {
    if (_subjectController.text.isEmpty ||
        _facultyController.text.isEmpty ||
        _fileName == null) {
      // Check if any field is empty or no file selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill all fields and select a file")),
      );
      return;
    }

    // Display confirmation with the submission details
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Assignment Submitted"),
        content: Text(
          "Subject: ${_subjectController.text}\n"
          "Faculty: ${_facultyController.text}\n"
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
    _subjectController.dispose();
    _facultyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignment Submission"),
        backgroundColor: const Color.fromARGB(255, 22, 17, 40),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Submit Your Assignment",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Subject field
            TextField(
              controller: _subjectController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Subject',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                fillColor: Color.fromARGB(255, 34, 34, 34),
                filled: true,
              ),
            ),
            const SizedBox(height: 15),

            // Faculty field
            TextField(
              controller: _facultyController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Faculty Name',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                fillColor: Color.fromARGB(255, 34, 34, 34),
                filled: true,
              ),
            ),
            const SizedBox(height: 15),

            // Pick file button
            ElevatedButton(
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("Choose PDF File"),
            ),
            if (_fileName != null) ...[
              const SizedBox(height: 10),
              Text(
                "Selected File: $_fileName",
                style: const TextStyle(color: Colors.white),
              ),
            ],
            const SizedBox(height: 20),

            // Date picker for submission date
            Row(
              children: [
                const Text(
                  "Submission Date: ",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(_selectedDate),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.green),
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

            // Submit button
            ElevatedButton(
              onPressed: _submitAssignment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("Submit Assignment"),
            ),
          ],
        ),
      ),
    );
  }
}
