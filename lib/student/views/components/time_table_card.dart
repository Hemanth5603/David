import 'package:flutter/material.dart';

Widget timeTableCard(facultyName, time, subject, room) {
  return Container(
    padding: EdgeInsets.all(15),
    width: 400,
    height: 50,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 232, 186),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color.fromARGB(255, 255, 146, 22))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              facultyName,
              style: TextStyle(
                  fontFamily: 'man-b',
                  fontSize: 16,
                  color: Color.fromARGB(223, 50, 50, 50)),
            ),
            Container(
              width: 30,
              height: 30,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: ClipOval(
                child: Image.asset(
                  "images/office_me.jpg",
                  fit: BoxFit.cover, // Ensures the image fills the circle
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 0,
        ),
        Text(
          subject,
          style: TextStyle(
            fontFamily: 'man-sb',
            fontSize: 14,
            color: Color.fromARGB(196, 37, 37, 37),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              room,
              style: const TextStyle(
                  fontFamily: 'man-r',
                  fontSize: 14,
                  color: Color.fromARGB(255, 51, 51, 51)),
            ),
            Text(
              time,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'man-sb',
                  color: Color.fromARGB(255, 51, 51, 51)),
            )
          ],
        )
      ],
    ),
  );
}
