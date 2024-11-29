import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:prototype/constants.dart';
import 'package:prototype/faculty/controllers/find_face_controller.dart';
import 'package:prototype/student/views/components/notification_card.dart';
import 'package:prototype/student/views/components/time_table_card.dart';

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
      backgroundColor: const Color.fromARGB(255, 244, 243, 236),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              SizedBox(
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
                      color:const Color.fromARGB(255, 252, 255, 249),
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
                                    padding:const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color:const Color.fromARGB(255, 255, 232, 169)
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/icons/leaf.png",
                                        fit: BoxFit.cover, // Ensures the image fills the circle
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  const Text("AQI", style: TextStyle(fontFamily: 'man-r',fontSize: 25, color: Colors.black),)
                                  
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
                      padding: EdgeInsets.fromLTRB(20,20,20,10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(216, 248, 211, 136)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Row(
                              children: [
                                Image.asset("assets/icons/star.png",width: 25,color: Constants.customOrange,),
                                SizedBox(width: 10,),
                                Text("YOUR ASSIGNMENT", style: TextStyle(fontSize: 30, color:Constants.customOrange,fontFamily: 'man-b' ),),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Prof. Saurav Sinha", style: TextStyle(fontFamily: 'man-b',fontSize: 12, color: Constants.customOrange),),
                                    Text("Database Schema", style: TextStyle(fontFamily: 'man-b', fontSize: 18, color: const Color.fromARGB(255, 33, 33, 33)),),
                                  ],
                                ),
                                Container(
                                  width: 60,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20), 
                                    //color: Color.fromARGB(112, 255, 255, 255),
                                    border: Border.all(color: Colors.black, width: 0.5)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("DBMS", style: TextStyle(fontFamily: 'man-r',fontSize: 10, color: const Color.fromARGB(197, 255, 143, 6)),),
                                      ],
                                  
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 7,),
                            Text("Design and implement a normalized database for the library management system. Include ER diagrams and SQL scripts for creating tables and relationships.",
                              style: TextStyle(fontFamily: 'man-L', fontSize: 12, color: Color.fromARGB(213, 39, 39, 39)),
                            ),
                            SizedBox(height: 25,),
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
              Padding(
                padding: EdgeInsets.only(left: 15, top: 20),
                child: Row(
                  children: [
                    Image.asset("assets/icons/star.png",width: 25,color: Constants.customOrange,),
                    SizedBox(width: 10,),
                    Text("NOTIFICATIONS", style: TextStyle(fontFamily: 'man-b',fontSize: 30, color: Constants.customOrange),),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: ListView(
                  children: [
                    notificationCard(MediaQuery.of(context).size.width),
                    notificationCard(MediaQuery.of(context).size.width),

                  ],
                ),
              )
              
          ],
        ),
      ),
    );
  }
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