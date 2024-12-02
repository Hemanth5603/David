import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/constants.dart';

import 'package:prototype/student/views/tabs/assignment_submission.dart';

Widget assignmentCard(w, prof, title, description, subject, due) {
  return Container(
    width: w,
    height: 220,
    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(214, 255, 236, 198)),
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
                  prof,
                  style: TextStyle(
                      fontFamily: 'man-b',
                      fontSize: 12,
                      color: Constants.customOrange),
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'man-b',
                      fontSize: 16,
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
                    subject,
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
        Container(
          height: 70,
          child: Text(
            description,
            style: TextStyle(
                fontFamily: 'man-L',
                fontSize: 12,
                color: Color.fromARGB(213, 39, 39, 39)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 130,
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
                    due,
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
                Get.to(AssignmentPage());
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
