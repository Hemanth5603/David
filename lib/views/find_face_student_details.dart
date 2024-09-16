import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/controllers/attendance_controller.dart';

class FindFaceStudentDetails extends StatefulWidget {
  const FindFaceStudentDetails({super.key});

  @override
  State<FindFaceStudentDetails> createState() => _FindFaceStudentDetailsState();
}

class _FindFaceStudentDetailsState extends State<FindFaceStudentDetails> {

  AttendanceController attendanceController = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255,35,37,49),
      body: SafeArea(
        child:Obx(() => attendanceController.isLoading.value ? 
          const Center(
            child: CircularProgressIndicator(),
          ):
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                padding: EdgeInsets.all(20),
                child: Text("Student Details", style: TextStyle(fontFamily: 'man-r', fontSize: 25, color: Colors.white),),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(36, 255, 255, 255)
                ),
                child: Row(
                  children: [
                    Text("Name: ", style: TextStyle(fontFamily: 'man-sb', fontSize: 20, color: Colors.white,),),
                    SizedBox(width: 10,),
                    Text(attendanceController.studentModel?.name.toString() ?? "Hemanth Srinivas", style: TextStyle(fontFamily: 'man-r', fontSize: 20, color: Colors.white),),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: [
                    Container(
                width: MediaQuery.of(context).size.width /2 - 20,
                height: 50,
               
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(36, 255, 255, 255)
                ),
                child: Row(
                  children: [
                    Text("Roll: ", style: TextStyle(fontFamily: 'man-sb', fontSize: 15, color: Colors.white,),),
                    SizedBox(width: 10,),
                    Text(attendanceController.studentModel?.roll.toString() ?? "213J1A4298", style: TextStyle(fontFamily: 'man-r', fontSize: 12, color: Colors.white),),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: MediaQuery.of(context).size.width /2 - 20,
                height: 60,
               
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(36, 255, 255, 255)
                ),
                child:Row(
                  children: [
                    Text("Academic Year: ", style: TextStyle(fontFamily: 'man-sb', fontSize: 15, color: Colors.white,),),
                    SizedBox(width: 10,),
                    Text(attendanceController.studentModel?.academic.toString() ?? "4th", style: TextStyle(fontFamily: 'man-r', fontSize: 12, color: Colors.white),),
                  ],
                ),
              ),
                  ],
                ),
              ),



              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: [
                    Container(
                width: MediaQuery.of(context).size.width /2 - 20,
                height: 50,
               
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(36, 255, 255, 255)
                ),
                child: Row(
                  children: [
                    Text("Branch: ", style: TextStyle(fontFamily: 'man-sb', fontSize: 15, color: Colors.white,),),
                    SizedBox(width: 10,),
                    Text(attendanceController.studentModel?.branch.toString() ?? "CSM", style: TextStyle(fontFamily: 'man-r', fontSize: 12, color: Colors.white),),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: MediaQuery.of(context).size.width /2 - 20,
                height: 60,
               
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(36, 255, 255, 255)
                ),
                child: Row(
                  children: [
                    Text("Section:  ", style: TextStyle(fontFamily: 'man-sb', fontSize: 15, color: Colors.white,),),
                    SizedBox(width: 10,),
                    Text(attendanceController.studentModel?.section.toString() ?? "C", style: TextStyle(fontFamily: 'man-r', fontSize: 12, color: Colors.white),),
                  ],
                ),
              ),
                    

                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  children: [
                    Container(
                width: MediaQuery.of(context).size.width /2 - 20,
                height: 50,
               
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(36, 255, 255, 255)
                ),
                child: Row(
                  children: [
                    Text("Semester: ", style: TextStyle(fontFamily: 'man-sb', fontSize: 15, color: Colors.white,),),
                    SizedBox(width: 10,),
                    Text(attendanceController.studentModel?.semester.toString() ?? "7th", style: TextStyle(fontFamily: 'man-r', fontSize: 12, color: Colors.white),),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: MediaQuery.of(context).size.width /2 - 20,
                height: 60,
               
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(36, 255, 255, 255)
                ),
                child: Row(
                  children: [
                    Text("Phone", style: TextStyle(fontFamily: 'man-sb', fontSize: 15, color: Colors.white,),),
                    SizedBox(width: 10,),
                    Text(attendanceController.studentModel?.phone.toString() ?? "7997435603", style: TextStyle(fontFamily: 'man-r', fontSize: 12, color: Colors.white),),
                  ],
                ),
              ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}