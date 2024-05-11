import 'package:flutter/material.dart';
import 'package:prototype/views/tabs/home_page.dart';
import 'package:prototype/views/tabs/profile.dart';



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
  HomeScreen(),
  Profile(),
  
];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
 

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Color.fromARGB(255, 74, 159, 255),
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