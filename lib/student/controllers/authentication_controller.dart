import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:prototype/services/auth_service.dart';
import 'package:prototype/student/views/home.dart';
import 'package:prototype/student/views/tabs/student_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student_model.dart';
import '../../api.dart';

class AuthenticationController extends GetxController {
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  // Login method
  Rx<StudentModel?> student = Rx<StudentModel?>(null);
  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse('${API.baseUrl}${API.login}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'roll_no': rollNoController.text,
          'password': passwordController.text,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == true) {
        student.value = StudentModel.fromJson(responseData);
        prefs.setString("branch", student.value!.student.branch);
        prefs.setString("roll", student.value!.student.rollNo);
        prefs.setString("id", student.value!.student.studentId.toString());

        await AuthService.to.loginAsStudent();
        Get.offAllNamed('/student/home');
      } else {
        print("Invalid Credentials");
      }
      isLoading(false);
    } catch (e) {
      print(e);
    }
  }

  void getUserByRoll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String roll = prefs.getString("roll") ?? '20CSE1001';
    try {
      final response = await http.get(
        Uri.parse('${API.baseUrl}${API.getUserByRoll}$roll'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == true) {
        student.value = StudentModel.fromJson(responseData);
        print(student.value!.student.firstName);
      } else {
        print("Invalid Credentials");
      }
    } catch (e) {
      print(e);
    }
  }

  void logout() {}
}
