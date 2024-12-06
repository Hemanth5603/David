import 'package:flutter/material.dart';

Widget notificationCard(
    w, title, description, date, titleColor, dateColor, descColor) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15),
    width: w,
    height: 100,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.black),
              child: ClipOval(
                child: Image.asset(
                  "images/office_me.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: w * 0.77,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontFamily: 'man-b', fontSize: 16, color: titleColor),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 30,
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
                          color: dateColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          date,
                          style: TextStyle(
                              fontFamily: 'man-r',
                              fontSize: 12,
                              color: dateColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: Text(
            description,
            textAlign: TextAlign.left,
            style:
                TextStyle(fontFamily: 'man-r', fontSize: 11, color: descColor),
          ),
        )
      ],
    ),
  );
}
