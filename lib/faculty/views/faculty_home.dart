import 'package:flutter/material.dart';
import 'package:prototype/faculty/views/tabs/assignment.dart';
import 'package:prototype/faculty/views/tabs/create_assignment.dart';
import 'package:prototype/faculty/views/tabs/faculty_profile.dart';
import 'package:prototype/faculty/views/tabs/home_page.dart';
import 'package:prototype/faculty/views/tabs/faculty_home_page.dart';
import 'package:prototype/student/views/tabs/assignment_submission.dart';

import 'package:prototype/student/views/tabs/home_page.dart';
import 'package:prototype/student/views/tabs/student_profile.dart';

class FacultyHome extends StatefulWidget {
  const FacultyHome({super.key});

  @override
  State<FacultyHome> createState() => _FacultyHomeState();
}

class _FacultyHomeState extends State<FacultyHome> {
  static List<BottomNavigationBarItem> tabs = const [
    BottomNavigationBarItem(
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.home_rounded,
        ),
        activeIcon: Icon(Icons.home_rounded),
        label: 'Home'),
    BottomNavigationBarItem(
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.notes_rounded,
        ),
        activeIcon: Icon(Icons.notes_rounded),
        label: 'Assignment'),
    BottomNavigationBarItem(
        backgroundColor: Colors.black,
        icon: Icon(Icons.person_rounded),
        activeIcon: Icon(Icons.person_rounded),
        label: 'Profile')
  ];
  int selectedIndex = 0;

  List<Widget> pages = [
    FacultyHomePage(),
    AssignmentPage(),
    FacultyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 35, 37, 49),
          selectedItemColor: Color.fromARGB(255, 174, 186, 255),
          unselectedItemColor: Color.fromARGB(255, 220, 220, 220),
          elevation: 10,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: tabs),
      body: pages[selectedIndex],
    );
  }
}
