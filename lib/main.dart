import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/auth/on_boarding.dart';
import 'package:prototype/faculty/views/home.dart';
import 'package:prototype/faculty/views/tabs/faculty_home_page.dart';
import 'package:prototype/services/auth_service.dart';
import 'package:prototype/student/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AuthService
  final authService = Get.put(AuthService());
  await authService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const InitialRouter()),
        GetPage(name: '/onboarding', page: () => OnBoardingPage()),
        GetPage(name: '/student/home', page: () => const StudentHome()),
        GetPage(name: '/faculty/home', page: () => const FacultyHomePage()),
      ],
    );
  }
}

class InitialRouter extends StatelessWidget {
  const InitialRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!AuthService.to.isLoggedIn.value) {
        return OnBoardingPage();
      }

      if (AuthService.to.userType.value == 'student') {
        return const StudentHome();
      } else if (AuthService.to.userType.value == 'faculty') {
        return const FacultyHomePage();
      }

      return OnBoardingPage();
    });
  }
}
