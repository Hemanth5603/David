import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/constants.dart';
import 'package:prototype/student/views/submit_assignment.dart';

Widget assignmentCard(w) {
  return Container(
    width: w,
    height: 220,
    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(215, 255, 232, 186)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Prof. Saurav Sinha",
                  style: TextStyle(
                      fontFamily: 'man-b',
                      fontSize: 12,
                      color: Constants.customOrange),
                ),
                Text(
                  "Database Schema",
                  style: TextStyle(
                      fontFamily: 'man-b',
                      fontSize: 18,
                      color: const Color.fromARGB(255, 33, 33, 33)),
                ),
              ],
            ),
            Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //color: Color.fromARGB(112, 255, 255, 255),
                  border: Border.all(color: Colors.black, width: 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "DBMS",
                    style: TextStyle(
                        fontFamily: 'man-r',
                        fontSize: 10,
                        color: const Color.fromARGB(197, 255, 143, 6)),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          "Design and implement a normalized database for the library management system. Include ER diagrams and SQL scripts for creating tables and relationships.",
          style: TextStyle(
              fontFamily: 'man-L',
              fontSize: 12,
              color: Color.fromARGB(213, 39, 39, 39)),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //color: Color.fromARGB(112, 255, 255, 255),
                  border: Border.all(color: Colors.black, width: 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/time.png",
                    width: 15,
                    color: Color.fromARGB(255, 255, 106, 57),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "27th-Nov",
                    style: TextStyle(
                        fontFamily: 'man-r',
                        fontSize: 12,
                        color: Color.fromARGB(255, 255, 106, 57)),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(AssignmentSubmissionPage());
              },
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(112, 255, 255, 255)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Submit",
                      style: TextStyle(
                          fontFamily: 'man-r',
                          fontSize: 12,
                          color: const Color.fromARGB(255, 52, 52, 52)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/icons/arrow.png",
                      width: 15,
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
