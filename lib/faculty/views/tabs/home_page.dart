import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/faculty/views/auth/register_face.dart';
import 'package:prototype/faculty/views/auth/register_face_form.dart';
import 'package:prototype/faculty/views/attendance/response_page.dart'; 
import 'package:prototype/faculty/views/speech.dart';
import 'package:prototype/faculty/views/tabs/profile.dart';
import 'package:prototype/faculty/views/attendance/video_record_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  bool isRecording = false;
  int index = 0;
 
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();    
  }

  List<String> items = ["CSM-C", "CSM-B", "CSM-A"];



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                      width: w,
                      height: h * 0.71,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 0, 86, 224),
                            Color.fromARGB(255, 255, 255, 255),
                        ],
                        stops: [0.0,1]
                        )
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 20,
                      child: Container(
                        width: w * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.white,width: 1),
                                    color: Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Icon(Icons.search,size:30,color: Colors.white,)
                                  ),
                                ),
                              
                            Row(
                              children: [
                                SizedBox(width: 10,),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.white,width: 1),
                                    color: Colors.transparent,
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: (){
                                        Get.to(Profile(),transition: Transition.rightToLeft, duration: 200.milliseconds);
                                      },
                                      child: Icon(Icons.person_outline_rounded, size: 30,color: Colors.white,))
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: h * 0.16,
                      left: w * 0.02,
                      child: Container(
                        padding: EdgeInsets.only(left: 18),
                        alignment: Alignment.topLeft,
                        width: w,
                        height: h * 0.12,
                        color: const Color.fromARGB(0, 0, 0, 0),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hello 👋",style: TextStyle(fontFamily: 'man-b',fontSize: 35,color: Colors.white, letterSpacing: 1),),
                            Text("Hemanth Srinivas",style: TextStyle(fontFamily: 'man-sb',fontSize: 25,color: Colors.white, letterSpacing: 1),)
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: h * 0.3,
                      left: w * 0.02,
                      child: Center(
                        child: Container(
                          padding:const EdgeInsets.all(10),
                          width: w * 0.98,
                          height: h * 0.18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(0, 255, 255, 255),
                            boxShadow: const [
                              BoxShadow(color: Color.fromARGB(0, 211, 211, 211), blurRadius: 2)
                            ]
                          ),
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: [
                               Card(w, h,"CSM-C","Data Structures","LH-5, Period - 1"),
                               Card(w, h,"CSM-B","Robotics", "LH-6, Period - 2"),
                              Card(w, h,"CSM-A","Data Analytics", "LH-1, Period - 3")
                            ],
                          ),
                        ),
                      )
                    ),
                    Positioned(
                      top: h * 0.48,
                      left: 10,
                      child: Container(
                        margin: const EdgeInsets.all(15),
              width: w,
              height: h * 0.035,
              padding: const EdgeInsets.only(left: 6),
              child: Text("Section - ${items[index]}",style: TextStyle(fontSize: 25,fontFamily: 'man-b'),),
            ),
                    ),
                    Positioned(
                      top: h * 0.54,
                      left: 0,
                      child:Padding(
              padding:const  EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(Speech(),transition: Transition.rightToLeft, duration: 200.milliseconds);
                          },
                          child: Container(
                            width: w * 0.95,
                            height: h * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                              begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight,
                          colors: [
                            Color.fromARGB(255, 159, 204, 250),
                            Color.fromARGB(255, 122, 184, 255),
                        ],
                        stops: [0.0,1]
                        )
                           ),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Transcribe Lecture ...", style: TextStyle(fontSize: 22,fontFamily: 'man-sb',color: Colors.white),),
                                  SizedBox(height: 4,),
                                  const Text("Record Audo 🎙", style: TextStyle(fontSize: 14,fontFamily: 'man-r',color: Colors.white),),
                                  
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 60,
                          right:-20,
                          child: Transform.rotate(
                            angle: 0,
                            child: Image(
                              image: AssetImage("images/record.png",),
                              width: 100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                    ),
              ],
            ),
            
            
                  Padding(padding:const  EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.to(RegisterFaceForm(), transition: Transition.downToUp, duration: 200.milliseconds);
                            },
                            child: Container(
                              width: w,
                              height: h * 0.15,
                             decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                              begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight,
                          colors: [
                            Color.fromARGB(255, 159, 204, 250),
                            Color.fromARGB(255, 122, 184, 255),
                        ],
                        stops: [0.0,1]
                        )
                             ),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Register Face ...", style: TextStyle(fontSize: 22,fontFamily: 'man-sb',color: Colors.white),),
                                    SizedBox(height: 4,),
                                    Text("Register New Student Face >", style: TextStyle(fontSize: 14,fontFamily: 'man-r',color: Colors.white),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right:-20,
                            child: Transform.rotate(
                              angle: -0.3,
                              child: const Image(
                                image: AssetImage("images/face.png",),
                                width: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  

                  Container(
                    width: w,
                    height: h * 0.3,
                  )
          ],
        ),
      )
    ); 
  }
}

Widget Card(w,h,className,subject,period){
  return  GestureDetector(
    onTap: (){
      Get.to(VideoRecordPage());
    },
    child: Container(
      margin: EdgeInsets.only(left: 3,right: 5),
      padding: EdgeInsets.all(12),
      width: w * 0.5,
      height: h * 0.1,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 234, 246, 255),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Color.fromARGB(255, 150, 150, 150), blurRadius: 2)
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(className, style: const TextStyle(fontFamily: 'man-r',fontSize: 18,color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),),
              Text(subject, style: const TextStyle(fontFamily: 'man-l',fontSize: 12,color: Color.fromARGB(255, 0, 0, 0)),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(period, style: const TextStyle(fontFamily: 'man-l',fontSize: 12,color: Color.fromARGB(255, 0, 0, 0)),),
              const Icon(Icons.arrow_forward_ios,size: 14,color: const Color.fromARGB(255, 0, 0, 0),)
            ],
          )
        ],
      ),
    ),
  );
}