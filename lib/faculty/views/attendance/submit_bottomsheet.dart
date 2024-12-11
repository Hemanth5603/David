import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/faculty/views/tabs/faculty_home_page.dart';

class bottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: w,
            height: h * 0.1,
            margin: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/check.png"))),
          ),
          const SizedBox(height: 20),
          const Text(
            'Attendance Sumbitted \n Successfully',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, fontFamily: 'man-l'),
          ),

          const Text(
            '',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, fontFamily: 'man-r'),
          ),
          const Spacer(), // Push the bottom container to the bottom
          GestureDetector(
            onTap: () {
              // Get.offAll(ImageCapture(),
              //     transition: Transition.leftToRight,
              //     duration: 300.milliseconds);
              Get.offAll(const FacultyHomePage(),
                  transition: Transition.leftToRight,
                  duration: 300.milliseconds);
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  'Go Back',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'poppins',
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
