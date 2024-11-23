import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/controllers/attendance_controller.dart';
import 'package:prototype/views/attendance/submit_bottomsheet.dart';
import 'package:prototype/views/tabs/homepage1.dart';

class ReviseAttendancePage extends StatefulWidget {
  const ReviseAttendancePage({super.key});

  @override
  State<ReviseAttendancePage> createState() => _ReviseAttendancePageState();
}

List<String> rolls = ["213J1A4201","213J1A4204","213J1A4206","213J1A4208","213J1A4212", "213J1A4220"];
List<String> absents = [
  "213J1A4240", "213J1A4252", "213J1A4210", "213J1A4207", "213J1A4236", 
  "213J1A4254", "213J1A4233", "213J1A4247", "213J1A4201", "213J1A4216", 
  "213J1A4228", "213J1A4230", "213J1A4218", "213J1A4245", "213J1A4235", 
  "213J1A4209", "213J1A4232", "213J1A4222", "213J1A4224", "213J1A4241", 
  "213J1A4211", "213J1A4251", "213J1A4206", "213J1A4225", "213J1A4246", 
];


class _ReviseAttendancePageState extends State<ReviseAttendancePage> {
  AttendanceController attendanceController = Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: (){
          showModalBottomSheet(context: context, builder: (context){
            return bottomSheetContent();
          });
        },
        child: Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(245, 40, 158, 255)
          ),
          child: Center(child: Text("Submit", style: TextStyle(fontFamily: 'man-r', fontSize: 18, color: Colors.white),),),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 35, 37, 49),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Text("Absents", style: TextStyle(fontSize: 26, fontFamily: 'man-r', color: Colors.white),),
              ),
              Expanded( // Use Expanded to allow ListView to take available space
                child: ListView.builder(
                  itemCount: attendanceController.attendanceResponseModel?.absents.length ?? absents.length,
                  itemBuilder: (context, index) {
                    return RollNumberCard(rollNumber: attendanceController.attendanceResponseModel?.absents[index].toString() ?? absents[index],); // Simply return the card
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RollNumberCard extends StatelessWidget { // Use StatelessWidget for a simple card
  String rollNumber;
  RollNumberCard({super.key,required this.rollNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width, 
      height: 55, // Fixed height for the card
      margin: EdgeInsets.symmetric(vertical: 5), 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(93, 255, 255, 255),
      ),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(rollNumber, style: TextStyle(color: Colors.white, fontFamily: 'man-r')),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: Center(
              child: Icon(Icons.add,size: 20,),
            ),
          )
        ],
      ), // Example text
    );
  }
}
