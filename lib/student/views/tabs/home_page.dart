import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:prototype/faculty/controllers/find_face_controller.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

List<Widget> timetable= [timeTableCard(), timeTableCard(), timeTableCard()];

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4E2D4),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 130,
                child: Row(
                  children: [
                    Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 90,
                              height: 80,
                              child:const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Hello 👋",style: TextStyle(fontFamily: 'man-b',fontSize: 25,color: Color.fromARGB(255, 36, 36, 36), letterSpacing: 1),),
                                  Text("Hemanth Srinivas", style: TextStyle(fontFamily: 'man-l', fontSize: 30, color: Color.fromARGB(255, 31, 31, 31)),)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 1)
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                "images/office_me.jpg",
                                fit: BoxFit.cover, // Ensures the image fills the circle
                              ),
                            ),
                          )
                        ],
                      ),
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 590,
                    decoration:  BoxDecoration(
                      color: Color.fromARGB(255, 252, 255, 249),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color.fromARGB(255, 255, 232, 169)
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/icons/leaf.png",
                                        fit: BoxFit.cover, // Ensures the image fills the circle
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("AQI", style: TextStyle(fontFamily: 'man-r',fontSize: 25, color: Colors.black),)
                                  
                                ],
                              ),
                              Text("1120",style: TextStyle(fontFamily: 'man-b', fontSize: 25, color: const Color.fromARGB(255, 244, 193, 54)),),
                          
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25.0,top: 10),
                          child: Text("Your Schedule", style: TextStyle(fontFamily: 'man-sb', fontSize: 25, color: Colors.black),),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 190,
                          child: CardSwiper(
                            cardsCount: timetable.length,
                            cardBuilder: (context,index, percentThresholdX,percentThresholdY) => timetable[index],
                            backCardOffset: const Offset(0,20),
                            numberOfCardsDisplayed: 3,

                          )
                        
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 340,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(216, 248, 211, 136)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("YOUR ASSIGNMENT", style: TextStyle(fontSize: 30, color:Color.fromARGB(197, 255, 148, 17),fontFamily: 'man-b' ),),
                            SizedBox(height: 8,),
                            Text("Database Schema", style: TextStyle(fontFamily: 'man-b', fontSize: 18, color: const Color.fromARGB(255, 33, 33, 33)),),
                            SizedBox(height: 7,),
                            Text("Design and implement a normalized database for the library management system. Include ER diagrams and SQL scripts for creating tables and relationships.",
                              style: TextStyle(fontFamily: 'man-L', fontSize: 12, color: Color.fromARGB(213, 39, 39, 39)),
                            ),
                            SizedBox(height: 32,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20), 
                                    //color: Color.fromARGB(112, 255, 255, 255),
                                    border: Border.all(color: Colors.black, width: 0.5)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        
                                        
                                        Image.asset("assets/icons/time.png", width: 15,color: Color.fromARGB(255, 255, 106, 57),),
                                        SizedBox(width: 10,),
                                        Text("27th-Nov", style: TextStyle(fontFamily: 'man-r',fontSize: 12, color: Color.fromARGB(255, 255, 106, 57)),),
                                      ],
                                  
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20), 
                                    color: Color.fromARGB(112, 255, 255, 255)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Submit", style: TextStyle(fontFamily: 'man-r',fontSize: 12, color: const Color.fromARGB(255, 52, 52, 52)),),
                                        SizedBox(width: 10,),
                                        Image.asset("assets/icons/arrow.png", width: 15,)
                                      ],
                                  
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              
              
          ],
        ),
      ),
    );
  }
}


Widget timeTableCard(){
  return Container(
    
    padding: EdgeInsets.all(15),
    width: 400,
    height: 50,
    decoration: BoxDecoration(
      color:Color.fromARGB(255, 255, 221, 154),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Color.fromARGB(255, 255, 146, 22))
      
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dr. Sahu", style: TextStyle(fontFamily: 'man-b',fontSize: 16, color: Color.fromARGB(223, 50, 50, 50)),),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50)
              ),
              child: ClipOval(
                child: Image.asset(
                  "images/office_me.jpg",
                  fit: BoxFit.cover, // Ensures the image fills the circle
                ),
              ),
            ),
           
            
          ],
        ),
        SizedBox(height: 0,),
        Text("Data Structures", style: TextStyle(fontFamily: 'man-sb', fontSize: 14, color: Color.fromARGB(196, 37, 37, 37),),), 
        const SizedBox(height:30,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("LH 21", style: TextStyle(fontFamily: 'man-r', fontSize: 14, color: Color.fromARGB(255, 51, 51, 51)),),
            Text("9:00 AM - 10:00 AM", style: TextStyle(fontSize: 12, fontFamily: 'man-sb', color: Color.fromARGB(255, 51, 51, 51)),)
          ],
        )
      ],
    ),
  );
}


Widget assignmentCard(){
  return Container(
    margin: EdgeInsets.fromLTRB(15, 15, 10, 15),
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Color.fromARGB(41, 174, 174, 174), spreadRadius: 1, blurRadius: 10)
      ]
    ),
  );
}