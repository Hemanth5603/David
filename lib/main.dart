import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prototype/firebase_options.dart';
import 'package:prototype/faculty/views/attendance/revise_attendance_page.dart';
import 'package:prototype/faculty/views/auth/signup.dart';
import 'package:prototype/faculty/views/find_face_student_details.dart';
import 'package:prototype/faculty/views/home.dart';
import 'package:prototype/faculty/views/attendance/response_page.dart';
import 'package:prototype/faculty/views/tabs/home_page.dart';
import 'package:prototype/faculty/views/tabs/homepage1.dart';
import 'package:prototype/student/views/tabs/home_page.dart';


void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor:Color.fromARGB(0, 35, 37, 49),
    )
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentHomePage(),
    );
  }
}
