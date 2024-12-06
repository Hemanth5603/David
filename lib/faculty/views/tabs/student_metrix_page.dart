import 'package:flutter/material.dart';

class StudentMetrixPage extends StatefulWidget {
  @override
  _StudentMetrixPageState createState() => _StudentMetrixPageState();
}

class _StudentMetrixPageState extends State<StudentMetrixPage> {
  final List<String> branches = ['CSE', 'CSM', 'CSO', 'IT', 'ECE', 'EEE', 'MECH', 'CIVIL'];
  String selectedBranch = 'CSE';
  double attendancePercentage = 70.0;

  final Map<String, double> branchAttendance = {
    'CSE': 78.2,
    'CSM': 83.5,
    'CSO': 67.9,
    'IT': 71.4,
    'ECE': 79.8,
    'EEE': 63.4,
    'MECH': 58.7,
    'CIVIL': 62.1,
  };

  final List<Map<String, dynamic>> students = [
    {'roll': '192001', 'name': 'Aarav Sharma', 'status': 'Present'},
    {'roll': '192002', 'name': 'Ishika Verma', 'status': 'Absent'},
    {'roll': '192003', 'name': 'Rohan Gupta', 'status': 'Present'},
    {'roll': '192004', 'name': 'Meera Iyer', 'status': 'Present'},
    {'roll': '192005', 'name': 'Karthik Reddy', 'status': 'Absent'},
    {'roll': '192006', 'name': 'Ananya Rao', 'status': 'Present'},
    {'roll': '192007', 'name': 'Vikram Jain', 'status': 'Absent'},
    {'roll': '192008', 'name': 'Pooja Singh', 'status': 'Present'},
    {'roll': '192009', 'name': 'Siddharth Joshi', 'status': 'Absent'},
    {'roll': '192010', 'name': 'Niharika Patil', 'status': 'Present'},
    {'roll': '192011', 'name': 'Neha Patil', 'status': 'Present'},
    {'roll': '192012', 'name': 'Pavi Raj', 'status': 'Present'},
    {'roll': '192013', 'name': 'Nikhil Reddy', 'status': 'Absent'},
    {'roll': '192014', 'name': 'Harini Chawla', 'status': 'Present'},
    {'roll': '192015', 'name': 'Krishna Menon', 'status': 'Absent'},
  ];

  void updateAttendance(String branch) {
    setState(() {
      selectedBranch = branch;
      attendancePercentage = branchAttendance[branch]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 47, 61),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 47, 61),
        title: const Text(
          'Student Metrix Page',
          style: TextStyle(
            fontFamily: 'man-sb',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Branch and Attendance Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 62, 63, 75),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: selectedBranch,
                    dropdownColor: const Color.fromARGB(255, 62, 63, 75),
                    style: const TextStyle(color: Colors.white, fontFamily: 'man-sb'),
                    underline: Container(height: 1, color: Colors.white),
                    items: branches
                        .map((branch) => DropdownMenuItem(
                              value: branch,
                              child: Text(branch),
                            ))
                        .toList(),
                    onChanged: (value) => updateAttendance(value!),
                  ),
                  Text(
                    '${attendancePercentage.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'man-b',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Table Container
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 62, 63, 75),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 38.0,
                      columns: const [
                        DataColumn(
                          label: Text('Roll', style: TextStyle(fontFamily: 'man-sb')),
                        ),
                        DataColumn(
                          label: Text('Name', style: TextStyle(fontFamily: 'man-sb')),
                        ),
                        DataColumn(
                          label: Text('Status', style: TextStyle(fontFamily: 'man-sb')),
                        ),
                      ],
                      rows: students
                          .map(
                            (student) => DataRow(
                              cells: [
                                DataCell(Text(student['roll'], style: const TextStyle(fontFamily: 'man-r'))),
                                DataCell(Text(student['name'], style: const TextStyle(fontFamily: 'man-r'))),
                                DataCell(Text(
                                  student['status'],
                                  style: TextStyle(
                                    fontFamily: 'man-r',
                                    color: student['status'] == 'Present' ? Colors.green : Colors.red,
                                  ),
                                )),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
