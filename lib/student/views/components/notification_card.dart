import 'package:flutter/material.dart';

Widget notificationCard(w){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15),

    width: w,
    height: 200,
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black
              ),
              child: ClipOval(
                child: Image.asset(
                  "images/office_me.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Text("FEST UPDATE", style: TextStyle(fontFamily: 'man-b',fontSize: 16, color: Color.fromARGB(255, 255, 143, 16)),),
            SizedBox(width: 110,),
            Container( 
              width: 100,
              height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), 
                  //color: Color.fromARGB(112, 255, 255, 255),
                  border: Border.all(color: Colors.black, width: 0.5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/time.png", width: 15,color: Color.fromARGB(255, 255, 106, 57),),
                      SizedBox(width: 10,),
                      Text("30th-Nov", style: TextStyle(fontFamily: 'man-r',fontSize: 12, color: Color.fromARGB(255, 255, 106, 57)),),
                    ],
                                  
                  ),
                ),
          ],
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: Text("📢 Exciting News! College Fest Approved 📢\n We are thrilled to announce that the college fest has officially been approved! The event is set to take place on 5th December. Prepare yourself for a day full of exciting activities, performances, and fun-filled competitions. More information about schedules, events, and registration will be shared soon. Let’s come together to make this fest unforgettable—get ready to celebrate!",
            style: TextStyle(fontFamily: 'man-r',fontSize: 11, color: Color.fromARGB(239, 87, 87, 87)),
          ),
        )
      ],
    ),
  );
}