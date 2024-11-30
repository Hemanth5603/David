import 'package:flutter/material.dart';
import 'package:prototype/constants.dart';
import 'package:prototype/student/views/tabs/calendar.dart';
import 'package:prototype/student/views/tabs/home_page.dart';
import 'package:prototype/student/views/tabs/student_profile.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => StudentHomeState();
}
  


  
class StudentHomeState extends State<StudentHome> {
  var selectedIndex = 0;
  late PageController pageController;


  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
    pageController.addListener(() {
      int currentPage = pageController.page!.round();
      if (currentPage != selectedIndex) {
        setState(() {
          selectedIndex = currentPage;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Color.fromARGB(255, 255, 160, 18),
          unselectedItemColor: Color.fromARGB(255, 255, 215, 154),
          elevation: 10,
          currentIndex: selectedIndex,
          onTap: (value){
            setState(() {
              if(value == 0){}
              selectedIndex = value;
            });
            pageController.animateToPage(selectedIndex,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutQuad);
          },
          items:Constants.tabs
         ),
        body: PageView(
              controller: pageController,
              children:<Widget> [
                const StudentHomePage(),
                const CalendarTab(),
                StudentProfile(),
              ],
            ),
    );
  }
}