import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/faculty/controllers/notification_controller.dart';

class CreateNotification extends StatelessWidget {
  CreateNotification({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  NotificationController notificationController =
      Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 27, 37),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Nofication",
                style: TextStyle(
                    fontFamily: 'man-b',
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width - 30,
                        child: Center(
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 54, 56, 77),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const []),
                            child: TextField(
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                  fontFamily: 'man-r', color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Color.fromARGB(255, 142, 118, 118),
                                hintText: "Title",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 26, 27, 37)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusColor:
                                    const Color.fromARGB(255, 223, 223, 223),
                                hintStyle: const TextStyle(
                                    fontFamily: 'man-r',
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 218, 218, 218)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 120,
                        width: MediaQuery.of(context).size.width - 30,
                        child: Center(
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 54, 56, 77),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const []),
                            child: TextField(
                              maxLines: 5,
                              controller: descriptionController,
                              keyboardType: TextInputType.multiline,
                              style: const TextStyle(
                                  fontFamily: 'man-r', color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: const Color.fromARGB(255, 13, 8, 8),
                                hintText: "Description",
                                contentPadding: EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 26, 27, 37)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusColor: Colors.black,
                                hintStyle: const TextStyle(
                                    fontFamily: 'man-r',
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 218, 218, 218)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  notificationController.createNotification(
                      titleController.text, descriptionController.text);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(30, 255, 255, 255)),
                  child: const Center(
                    child: Text(
                      "Notify",
                      style: TextStyle(
                          fontFamily: 'man-r',
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
