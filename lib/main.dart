import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prototype/firebase_options.dart';
import 'package:prototype/views/auth/signup.dart';
import 'package:prototype/views/find_face_student_details.dart';
import 'package:prototype/views/home.dart';
import 'package:prototype/views/attendance/response_page.dart';
import 'package:prototype/views/tabs/home_page.dart';
import 'package:prototype/views/tabs/homepage1.dart';


void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
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
      home: HomePage1(),
    );
  }
}
