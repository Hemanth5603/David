

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:prototype/controllers/attendance_controller.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class ResponsePage extends StatefulWidget {
  const ResponsePage({super.key});

  @override
  State<ResponsePage> createState() => _ResponsePageState();
}
AttendanceController attendanceController = Get.put(AttendanceController());
class _ResponsePageState extends State<ResponsePage> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
      ),
      body: SafeArea(
        child: Obx(() => attendanceController.isLoading.value ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 5,),
              Text("Alalysing Faces ...", style: TextStyle(fontFamily: 'man-r', fontSize: 12,color: Colors.black),)
            ],
          ),
        ) : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: w,
                height: h * 0.15,
                padding: EdgeInsets.symmetric(horizontal:15,vertical: 10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue
                ),
                child: Row(
                  children: [
                    Container(
                      width: w * 0.4,
                      height: h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Presentes",style: TextStyle(fontFamily: 'man-sb',fontSize: 25,color: Colors.white),),
                          Text("28th April, 2024",style: TextStyle(fontFamily: 'man-l',fontSize: 14,color: Colors.white),),
                          SizedBox(height: 30,),
                          Text("Presents/Absents : ${attendanceController.rollModel?.presents.length}'/'${attendanceController.rollModel?.absents.length}",style: TextStyle(fontSize:11 ,fontFamily: 'man-r',color: Colors.white,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                    
                    Container(
                      width: w * 0.4,
                      height: h,

                      alignment: Alignment.centerRight,
                      child: SimpleCircularProgressBar(
                        size: 60,
                        progressStrokeWidth: 12,
                        backColor: Colors.white,
                        backStrokeWidth: 12,
                        maxValue: 40,
                        progressColors: [Color.fromARGB(255, 72, 100, 255)],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: w,
                height: h * 0.08,
                margin: EdgeInsets.only(left: 5),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          check = true;
                        });
                      },
                      child: Container(
                        width: w * 0.45,
                        height: h*0.6,
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:check == true ? Color.fromARGB(255, 123, 193, 255) :const Color.fromARGB(255, 225, 241, 255)
                        ),
                        child: Center(
                          child: Text("Presents",style: TextStyle(fontFamily: 'man-r',fontSize: 18),),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          check =false;
                        });
                      },
                      child: Container(
                        width: w * 0.45,
                        height: h*0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:check == true ?  const Color.fromARGB(255, 225, 241, 255): Color.fromARGB(255, 123, 193, 255)
                        ),
                        child: Center(
                          child: Text("Absents",style: TextStyle(fontFamily: 'man-r',fontSize: 18),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              check == true ? Container(
                width: w,
                height: h * 0.5,
                child:attendanceController.rollModel!.presents.isEmpty ? Container(): ListView.builder(
                  itemCount: attendanceController.rollModel?.presents.length,
                  itemBuilder: (context,index){
                    return RollNumberCard(w, h, 
                      attendanceController.rollModel!.presents[index].roll.toString(),
                      attendanceController.rollModel!.presents[index].name.toString(), true,
                    );
                  }
                ),
              ) : Container(
                width: w,
                height: h * 0.5,
                child: ListView.builder(
                  itemCount: attendanceController.rollModel?.presents.length,
                  itemBuilder: (context,index){
                    return RollNumberCard(w, h, 
                      attendanceController.rollModel!.absents[index].roll.toString(),
                      attendanceController.rollModel!.absents[index].name.toString(), false,
                    );
                  }
                ),
              )
              
            ],
          ),
        ),
      ),
      )
    );
  }
}

Widget RollNumberCard(double w,double h,String roll,String name, bool isPresent){
  return Container(
    width: w,
    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 12),
    height: h * 0.09,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 219, 233, 255)
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(roll,style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: 'man-sb'),),
              SizedBox(height: 5,),
              Text(name,style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: 'man-l'),),
            ],
          ),
          Text(isPresent? "Present":"Absent", 
            style: TextStyle(color: isPresent ? Colors.green : Colors.red,fontSize: 18),
          )
        ],
      ),
    ),
  );
}