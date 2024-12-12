import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/faculty/controllers/camera_controller.dart';
import 'package:prototype/faculty/controllers/notification_controller.dart';
import 'package:prototype/faculty/views/forms/create_notification.dart';
import 'package:prototype/faculty/views/image_capture.dart';
import 'package:prototype/faculty/views/auth/register_face.dart';
import 'package:prototype/faculty/views/auth/register_face_form.dart';
import 'package:prototype/faculty/views/speech.dart';
import 'package:prototype/faculty/views/tabs/faculty_profile.dart';
import 'package:prototype/faculty/views/attendance/video_record_page.dart';
import 'package:prototype/faculty/views/tabs/resource_allocation.dart';
import 'package:prototype/student/controllers/notification_controller.dart';
import 'package:prototype/student/views/components/notification_card.dart';
import 'package:url_launcher/url_launcher.dart';

class FacultyHomePage extends StatefulWidget {
  const FacultyHomePage({super.key});

  @override
  State<FacultyHomePage> createState() => _FacultyHomePageState();
}

List<String> transcribesDesc = [
  "Lecture - 1, Data Structures and Algorithms",
  "Lecture - 2, Operating Systems",
  "Lecture - 3, Theory of Computation",
  "Lecture - 4, DBMS"
];
List<String> links = [
  "https://docs.google.com/document/d/1Q6ai9DEUMhTGA3-m4oqMqas_E7WbLj07Jp9ZaO9dWZk/edit?usp=sharing",
  "https://docs.google.com/document/d/1Wq3gKNECH0DleYxP_f6DvMC9lX7mV4kBgGHV3MIAbmM/edit?usp=sharing",
  "https://docs.google.com/document/d/1Q6ai9DEUMhTGA3-m4oqMqas_E7WbLj07Jp9ZaO9dWZk/edit?usp=sharing",
  "https://docs.google.com/document/d/1Wq3gKNECH0DleYxP_f6DvMC9lX7mV4kBgGHV3MIAbmM/edit?usp=sharing",
];

StudentNotificationController notificationController =
    Get.put(StudentNotificationController());

class _FacultyHomePageState extends State<FacultyHomePage> {
  @override
  Widget build(BuildContext context) {
    final Camera camera = Get.put(Camera());
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(RegisterFaceForm(),
              transition: Transition.rightToLeft, duration: 300.milliseconds);
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color.fromARGB(255, 100, 106, 139)),
          child: Center(
            child: Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 35, 37, 49),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                width: w,
                height: h * 0.12,
                color: const Color.fromARGB(0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Hello 👋",
                          style: TextStyle(
                              fontFamily: 'man-b',
                              fontSize: 35,
                              color: Colors.white,
                              letterSpacing: 1),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white, width: 1),
                            color: Colors.transparent,
                          ),
                          child: Center(
                              child: GestureDetector(
                                  onTap: () {
                                    // showModalBottomSheet(
                                    //   context: context,
                                    //   builder: (context) {
                                    //     return CreateNotification();
                                    //   },
                                    // );
                                    Get.to(CreateNotification(),
                                        transition: Transition.rightToLeft,
                                        duration: 200.milliseconds);
                                  },
                                  child: Icon(
                                    Icons.notifications,
                                    size: 20,
                                    color: Colors.white,
                                  ))),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white, width: 1),
                            color: Colors.transparent,
                          ),
                          child: Center(
                              child: GestureDetector(
                                  onTap: () {
                                    Get.to(ResourceAllocationPage(),
                                        transition: Transition.rightToLeft,
                                        duration: 200.milliseconds);
                                  },
                                  child: Icon(
                                    Icons.storage_outlined,
                                    size: 20,
                                    color: Colors.white,
                                  ))),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white, width: 1),
                            color: Colors.transparent,
                          ),
                          child: Center(
                              child: GestureDetector(
                                  onTap: () {
                                    Get.to(FacultyProfilePage(),
                                        transition: Transition.rightToLeft,
                                        duration: 200.milliseconds);
                                  },
                                  child: Icon(
                                    Icons.person_outline_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  ))),
                        ),
                      ],
                    ),
                    Text(
                      "I am David!",
                      style: TextStyle(
                          fontFamily: 'man-sb',
                          fontSize: 25,
                          color: Colors.white,
                          letterSpacing: 1),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  width: w * 0.98,
                  height: h * 0.18,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(0, 255, 255, 255),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(0, 211, 211, 211),
                            blurRadius: 2)
                      ]),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Card(
                          w, h, "CSE", "Data Structures", "LH-101, Period - 1"),
                      Card(w, h, "CSM", "Robotics", "LH-101, Period - 2"),
                      Card(w, h, "CSD", "Data Analytics", "LH-101, Period - 3")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: w,
                height: 220,
                child: Row(
                  // spacing between rows
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.to(ImageCapture());
                        },
                        child: featureCard(
                            w,
                            h,
                            Color.fromARGB(255, 255, 153, 98),
                            "Find Face",
                            "assets/icons/face.png",
                            294,
                            "Fetch Student details just by taking a snap of the student")),
                    GestureDetector(
                        onTap: () {
                          Get.to(Speech(),
                              transition: Transition.rightToLeft,
                              duration: 300.milliseconds);
                        },
                        child: featureCard(
                            w,
                            h,
                            Color.fromARGB(255, 189, 244, 118),
                            "Transcribe Lecture",
                            "assets/icons/voice.png",
                            10,
                            "Transcribe lectures converted into pdf by recording the live lecture from voice")),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your Notifications",
                  style: TextStyle(
                      fontFamily: 'man-r',
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: Obx(() {
                  final notifications = notificationController
                          .notifications.value?.notifications ??
                      [];
                  return ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return notificationCard(
                          MediaQuery.of(context).size.width,
                          notification.title,
                          notification.description,
                          notification.createdAt.split('T')[0],
                          Colors.white,
                          Colors.orange,
                          Colors.grey);
                    },
                  );
                }),
              ),
              SizedBox(
                height: h * 0.5,
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*--------------------------------------------------------------------------------------------------------------------------*/

Widget Card(w, h, className, subject, period) {
  return GestureDetector(
    onTap: () {
      Get.to(VideoRecordPage());
    },
    child: Container(
      margin: EdgeInsets.only(left: 3, right: 5),
      padding: EdgeInsets.all(15),
      width: w - 20,
      height: h * 0.1,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 254, 221, 105),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: Color.fromARGB(255, 150, 150, 150), blurRadius: 2)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    className,
                    style: const TextStyle(
                        fontFamily: 'man-r',
                        fontSize: 22,
                        color: Color.fromARGB(255, 35, 37, 49),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    period,
                    style: const TextStyle(
                        fontFamily: 'man-l',
                        fontSize: 12,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
              Text(
                subject,
                style: const TextStyle(
                    fontFamily: 'man-l',
                    fontSize: 14,
                    color: Color.fromARGB(255, 0, 0, 0)),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/icons/attendance.png",
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "72",
                    style: TextStyle(fontFamily: 'man-r', fontSize: 40),
                  )
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: const Color.fromARGB(255, 0, 0, 0),
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget featureCard(w, h, color, title, icon, value, desc) {
  return Container(
      margin: EdgeInsets.all(5),
      width: w / 2 - 15,
      height: 700,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    width: 110,
                    height: 50,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontFamily: 'man-r',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromARGB(125, 255, 255, 255)),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/arrow.png',
                      width: 20,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    icon,
                    width: 50,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    value.toString(),
                    style: TextStyle(
                      fontFamily: 'man-r',
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              desc,
              style: TextStyle(fontFamily: 'man-r', fontSize: 10),
            ),
          ],
        ),
      ));
}

Widget transcribes(desc, link) {
  return GestureDetector(
    onTap: () {
      launchDocument(link);
    },
    child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 100, 106, 139),
                ),
                child: Center(
                  child: Icon(
                    Icons.mic_none_outlined,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                  width: 200,
                  child: Text(
                    desc,
                    style: TextStyle(
                        fontSize: 14, color: Colors.white, fontFamily: 'man-r'),
                  )),
              SizedBox(
                width: 70,
              ),
              Image.asset(
                "assets/icons/dots.png",
                color: Colors.white,
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          // Container(
          //   width: 400,
          //   margin: EdgeInsets.symmetric(horizontal: 50),
          //   height: 1,
          //   color: Color.fromARGB(45, 255, 255, 255),
          // )
        ],
      ),
    ),
  );
}

Future<void> launchDocument(link) async {
  var url = Uri.parse(link.toString());
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
