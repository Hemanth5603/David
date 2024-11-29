import 'package:flutter/material.dart';
import 'package:prototype/faculty/views/tabs/home_page.dart';
import 'package:prototype/faculty/views/tabs/homepage1.dart';
import 'package:prototype/faculty/views/tabs/faculty_profile.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

static List<BottomNavigationBarItem> tabs = const [
      BottomNavigationBarItem(
        backgroundColor: Colors.black,
          icon: Icon(Icons.home_rounded,),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_rounded),
        activeIcon: Icon(Icons.person_rounded),
        label: 'Profile'
      )
   ];
      int selectedIndex = 0;

List<Widget> pages = [
  HomePage1(),
  FacultyProfilePage(),
  
];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
 

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255,35,37,49),
          selectedItemColor: Color.fromARGB(255, 174, 186, 255),
          unselectedItemColor: Color.fromARGB(255, 220, 220, 220),
          elevation: 10,
          currentIndex: selectedIndex,
          onTap: (value){
            setState(() {
    
              selectedIndex = value;
            });
            
          },
          items:tabs
         ),
      body:  pages[selectedIndex],
      
  
    );
  }
}