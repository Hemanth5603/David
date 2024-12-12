import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:prototype/faculty/controllers/attendance_controller.dart';
import 'package:prototype/faculty/views/attendance/revise_attendance_page.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class ResponsePage extends StatefulWidget {
  const ResponsePage({super.key});

  @override
  State<ResponsePage> createState() => _ResponsePageState();
}

List<String> presents = [
  "213J1A42C9",
  "213J1A4229",
  "213J1A4219",
  "213J1A4213",
  "213J1A4242",
  "213J1A4250",
  "213J1A4242",
  "213J1A4244",
  "213J1A4297",
  "213J1A4282",
  "213J1A4288",
  "213J1A4249",
  "213J1A4221"
];
List<String> absents = [
  "213J1A4240",
  "213J1A4252",
  "213J1A4210",
  "213J1A4207",
  "213J1A4236",
  "213J1A4254",
  "213J1A4233",
  "213J1A4247",
  "213J1A4201",
  "213J1A4216",
  "213J1A4228",
  "213J1A4230",
  "213J1A4218",
  "213J1A4245",
  "213J1A4235",
  "213J1A4209",
  "213J1A4232",
  "213J1A4222",
  "213J1A4224",
  "213J1A4241",
  "213J1A4211",
  "213J1A4251",
  "213J1A4206",
  "213J1A4225",
  "213J1A4246",
];

AttendanceController attendanceController = Get.put(AttendanceController());

class _ResponsePageState extends State<ResponsePage> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        bottomNavigationBar: GestureDetector(
          onTap: () => Get.to(ReviseAttendancePage()),
          child: Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(53, 255, 255, 255),
            ),
            child: Center(
              child: Text(
                "Revise Attendance",
                style: TextStyle(
                    fontFamily: 'man-r', fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 35, 37, 49),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 35, 37, 49),
          title: Text(
            "Attendance",
            style: TextStyle(fontFamily: 'man-r', color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => attendanceController.isLoading.value
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Alalyzing Faces ...",
                          style: TextStyle(
                              fontFamily: 'man-r',
                              fontSize: 12,
                              color: Colors.black),
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: w,
                          height: h * 0.15,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(255, 201, 159, 255)),
                          child: Row(
                            children: [
                              Container(
                                width: w * 0.4,
                                height: h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Presentes",
                                      style: TextStyle(
                                          fontFamily: 'man-sb',
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "9th August, 2024",
                                      style: TextStyle(
                                          fontFamily: 'man-l',
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Presents/Absents : ${attendanceController.attendanceResponseModel?.presents.length ?? "13"}'/'${attendanceController.attendanceResponseModel?.absents.length ?? "25"}",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: 'man-r',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),

                              // Container(
                              //   width: w * 0.4,
                              //   height: h,

                              //   alignment: Alignment.centerRight,
                              //   child: SimpleCircularProgressBar(
                              //     size: 60,
                              //     progressStrokeWidth: 12,
                              //     backColor: Colors.white,
                              //     backStrokeWidth: 12,
                              //     maxValue: 40,
                              //     progressColors: [Color.fromARGB(255, 72, 100, 255)],
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: w,
                          height: h * 0.08,
                          margin: EdgeInsets.only(left: 5),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    check = true;
                                  });
                                },
                                child: Container(
                                  width: w * 0.45,
                                  height: h * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: check == true
                                          ? Color.fromARGB(255, 148, 218, 251)
                                          : const Color.fromARGB(
                                              255, 225, 241, 255)),
                                  child: Center(
                                    child: Text(
                                      "Presents",
                                      style: TextStyle(
                                          fontFamily: 'man-r', fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    check = false;
                                  });
                                },
                                child: Container(
                                  width: w * 0.45,
                                  height: h * 0.8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: check == true
                                          ? const Color.fromARGB(
                                              255, 225, 241, 255)
                                          : Color.fromARGB(255, 123, 193, 255)),
                                  child: Center(
                                    child: Text(
                                      "Absents",
                                      style: TextStyle(
                                          fontFamily: 'man-r', fontSize: 18),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        check == true
                            ? Container(
                                width: w,
                                height: h * 0.5,
                                child:
                                    // (attendanceController.attendanceResponseModel?.presents.isEmpty ?? true)
                                    //   ? Container(child: Center(child: Text("No Students Detected",style: TextStyle(fontFamily: 'man-r',fontSize: 14, color: Colors.white),)))
                                    //   :
                                    ListView.builder(
                                  itemCount: attendanceController
                                          .attendanceResponseModel
                                          ?.presents
                                          .length ??
                                      presents.length,
                                  itemBuilder: (context, index) {
                                    return RollNumberCard(
                                      w,
                                      h,
                                      attendanceController
                                              .attendanceResponseModel
                                              ?.presents[index]
                                              .toString() ??
                                          presents[index],
                                      attendanceController
                                              .attendanceResponseModel
                                              ?.presents[index]
                                              .toString() ??
                                          presents[index],
                                      true,
                                    );
                                  },
                                ),
                              )
                            : Container(
                                width: w,
                                height: h * 0.5,
                                child: ListView.builder(
                                  itemCount: attendanceController
                                          .attendanceResponseModel
                                          ?.absents
                                          .length ??
                                      absents.length,
                                  itemBuilder: (context, index) {
                                    return RollNumberCard(
                                      w,
                                      h,
                                      attendanceController
                                              .attendanceResponseModel
                                              ?.absents[index]
                                              .toString() ??
                                          absents[index],
                                      attendanceController
                                              .attendanceResponseModel
                                              ?.absents[index]
                                              .toString() ??
                                          absents[index],
                                      false,
                                    );
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
          ),
        ));
  }
}

Widget RollNumberCard(
    double w, double h, String roll, String name, bool isPresent) {
  return Container(
    width: w,
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
    height: h * 0.09,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 219, 233, 255)),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                roll,
                style: TextStyle(
                    fontSize: 18, color: Colors.black, fontFamily: 'man-sb'),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 14, color: Colors.black, fontFamily: 'man-l'),
              ),
            ],
          ),
          Text(
            isPresent ? "Present" : "Absent",
            style: TextStyle(
                color: isPresent ? Colors.green : Colors.red, fontSize: 18),
          )
        ],
      ),
    ),
  );
}
