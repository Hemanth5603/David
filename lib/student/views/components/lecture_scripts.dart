import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/faculty/views/screens/pdf_viewer_screen.dart';
import 'package:prototype/student/controllers/lecture_scripts_controller.dart';
import 'package:prototype/student/views/components/feedback.dart';

class LectureScripts extends StatefulWidget {
  const LectureScripts({super.key});

  @override
  State<LectureScripts> createState() => _LectureScriptsState();
}

final LectureScriptsController lectureScriptController =
    Get.put(LectureScriptsController());

class _LectureScriptsState extends State<LectureScripts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lecture Scripts",
                  style: TextStyle(
                      fontFamily: 'man-sb', fontSize: 25, color: Colors.black),
                ),
                IconButton(
                    onPressed: () {
                      Get.to(FeedbackPage(lectureTitle: "DBMS"));
                    },
                    icon: Icon(Icons.edit))
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Obx(
                () => lectureScriptController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: lectureScriptController
                            .lectureScript.value!.data.length,
                        itemBuilder: (context, index) {
                          final lecture =
                              lectureScriptController.lectureScript.value!.data;
                          return LectureTile(
                            MediaQuery.of(context).size.width,
                            lecture[index].facultyId,
                            lecture[index].branch,
                            lecture[index].topics,
                            lecture[index].createdAt,
                            pdfUrl: lecture[index].filePath,
                          );
                        }),
              ))
        ],
      ),
    );
  }
}

Widget LectureTile(w, name, branch, topics, String date, {String? pdfUrl}) {
  return GestureDetector(
    onTap: () {
      if (pdfUrl != null) {
        Get.to(() => PDFViewerScreen(pdfUrl: pdfUrl));
      }
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: w,
      height: 70,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(212, 253, 242, 231),
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
                      "DBMS-${branch}",
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
                          "",
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
