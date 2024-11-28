import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prototype/faculty/controllers/user_controller.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _LoginState();
}

class _LoginState extends State<StudentLogin> {
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 255, 255, 255), // Change the color to your desired color
      statusBarIconBrightness: Brightness.dark, // Change the brightness of icons
    ));

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: w,
                height: h * 0.4,
                decoration: const BoxDecoration(),
                child: Center(
                  child: Container(
                    width: w * 0.2,
                    height: w * 0.2,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.black,
                    ),
                    child: Center(child: Image.asset("images/icon.png")),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Welcome Back !",
                        style: TextStyle(
                          fontFamily: 'man-b',
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Roll Number Input
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 45,
                        width: w,
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            SizedBox(
                              height: h * 0.12,
                              width: w * 0.8,
                              child: Center(
                                child: TextField(
                                  controller: userController.rollNumber, // Updated to rollNumber controller
                                  keyboardType: TextInputType.text,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  style: const TextStyle(fontFamily: 'man-r'),
                                  decoration: const InputDecoration(
                                    hintText: "Roll Number", // Updated label
                                    hintStyle: TextStyle(color: Color.fromARGB(255, 106, 106, 106)),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(255, 0, 0, 0), width: 5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Password Input
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 45,
                        width: w,
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            SizedBox(
                              height: h * 0.12,
                              width: w * 0.8,
                              child: Center(
                                child: TextField(
                                  controller: userController.password,
                                  keyboardType: TextInputType.text,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  obscureText: true,
                                  style: const TextStyle(fontFamily: 'man-r'),
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Color.fromARGB(255, 106, 106, 106)),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(255, 0, 0, 0), width: 5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 50,
                          width: w * 0.89,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
                            color: Colors.black,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                            child: Text(
                              "Log in",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        await userController.signInWithRollNumberPassword();
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ? ",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        GestureDetector(
                          child: const Text(
                            "Create Account",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Get.back();
                          },
                        )
                      ],
                    ),
                    SizedBox(height: h * 0.22),
                    Container(
                      margin: const EdgeInsets.only(left: 80),
                      child: const Column(
                        children: [
                          Text(
                            "By Continuing you agree ",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Terms of Service   Privacy Policy ",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
