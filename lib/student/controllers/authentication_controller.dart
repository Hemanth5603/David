import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:prototype/services/auth_service.dart';
import 'package:prototype/student/views/home.dart';
import '../models/student_model.dart';
import '../../api.dart';

class AuthenticationController extends GetxController {
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // Login method
  Rx<StudentModel?> student = Rx<StudentModel?>(null);
  void login() async {
    try {
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
        await AuthService.to.loginAsStudent();
        Get.offAllNamed('/student/home');
      } else {
        print("Invalid Credentials");
      }
    } catch (e) {
      print(e);
    }
  }
}
