import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/faculty/views/screens/pdf_viewer_screen.dart';

Widget AssignmentSubmittedCard(w, name, branch, subject, String date,
    {String? pdfUrl}) {
  return GestureDetector(
    onTap: () {
      if (pdfUrl != null) {
        Get.to(() => PDFViewerScreen(pdfUrl: pdfUrl));
      }
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: w,
      height: 70,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(213, 255, 254, 253),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(255, 255, 101, 101),
            ),
            child: Center(
                child: Text("PDF",
                    style: TextStyle(
                        fontFamily: 'man-sb',
                        color: Colors.white,
                        fontSize: 16))),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 240,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${name}-${branch}",
                      style: TextStyle(
                          fontFamily: 'man-sb',
                          fontSize: 16,
                          color: const Color.fromARGB(255, 69, 69, 69)),
                    ),
                    Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(84, 241, 241, 241),
                      ),
                      child: Center(
                        child: Text(
                          subject,
                          style: TextStyle(
                              fontFamily: 'man-r',
                              fontSize: 10,
                              color: const Color.fromARGB(255, 69, 69, 69)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Date: ${date.substring(0, 10)}",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'man-l',
                    color: const Color.fromARGB(255, 81, 81, 81)),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
