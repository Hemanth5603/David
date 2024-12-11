import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/student/controllers/leave_request_controller.dart';

class LeaveRequestPage extends StatefulWidget {
  @override
  _LeaveRequestPageState createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  // Dummy student details for demonstration
  final String studentId = "S12345";
  final String studentName = "John Doe";
  final String branch = "ECE";
  final String rollNumber = "18ECE101";
  final LeaveRequestController leaveRequestController =
      Get.put(LeaveRequestController());
  // Controllers for user input
  final TextEditingController classInchargeController = TextEditingController();
  final TextEditingController adminNameController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Letter',
          style: TextStyle(fontFamily: 'man-sb', color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 35, 37, 49),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // // Display student details
              // Text(
              //   'Apply Leave Request',
              //   style: TextStyle(
              //       fontFamily: 'man-b', fontSize: 18, color: Colors.blueGrey),
              // ),
              SizedBox(height: 10),
              // Text('ID: $studentId',
              //     style: TextStyle(
              //         fontFamily: 'man-r',
              //         fontSize: 16,
              //         color: Colors.black54)),
              // Text('Name: $studentName',
              //     style: TextStyle(
              //         fontFamily: 'man-r',
              //         fontSize: 16,
              //         color: Colors.black54)),
              // Text('Branch: $branch',
              //     style: TextStyle(
              //         fontFamily: 'man-r',
              //         fontSize: 16,
              //         color: Colors.black54)),
              // Text('Roll Number: $rollNumber',
              //     style: TextStyle(
              //         fontFamily: 'man-r',
              //         fontSize: 16,
              //         color: Colors.black54)),
              SizedBox(height: 20),

              // Class Incharge Input
              TextField(
                controller: classInchargeController,
                decoration: InputDecoration(
                  labelText: 'Class Incharge Name',
                  labelStyle:
                      TextStyle(fontFamily: 'man-l', color: Colors.blueGrey),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                ),
                style: TextStyle(fontFamily: 'man-r'),
              ),
              SizedBox(height: 15),

              // Admin Name Input
              TextField(
                controller: adminNameController,
                decoration: InputDecoration(
                  labelText: 'Admin Name',
                  labelStyle:
                      TextStyle(fontFamily: 'man-l', color: Colors.blueGrey),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                ),
                style: TextStyle(fontFamily: 'man-r'),
              ),
              SizedBox(height: 15),

              // Subject Input
              TextField(
                controller: subjectController,
                decoration: InputDecoration(
                  labelText: 'Subject',
                  labelStyle:
                      TextStyle(fontFamily: 'man-l', color: Colors.blueGrey),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                ),
                style: TextStyle(fontFamily: 'man-r'),
              ),
              SizedBox(height: 15),

              // Reason Input
              TextField(
                controller: reasonController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Reason',
                  labelStyle:
                      TextStyle(fontFamily: 'man-l', color: Colors.blueGrey),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                ),
                style: TextStyle(fontFamily: 'man-r'),
              ),
              SizedBox(height: 20),

              // Send Request Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    // Handle send request logic
                    String classIncharge = classInchargeController.text;
                    String adminName = adminNameController.text;
                    String subject = subjectController.text;
                    String reason = reasonController.text;
                    await leaveRequestController.sendLeaveRequest(
                        adminName, classIncharge, subject, reason);
                    if (classIncharge.isEmpty ||
                        adminName.isEmpty ||
                        subject.isEmpty ||
                        reason.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please fill in all fields!',
                            style: TextStyle(fontFamily: 'man-r'),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );

                      return;
                    }

                    // Simulate request submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Leave request sent successfully!',
                          style: TextStyle(fontFamily: 'man-r'),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 35, 37, 49),
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(Icons.send, color: Colors.white),
                  label: Text(
                    'Send Request',
                    style: TextStyle(
                        fontFamily: 'man-sb',
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
