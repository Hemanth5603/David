import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prototype/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FacultyAttendanceController extends GetxController {
  var isLoading = false.obs;
  var filePath = ''.obs;

  void takeFacultyAttendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String branch = prefs.getString("fbranch") ?? 'CSE';
    try {
      final response = await http.post(
        Uri.parse('${API.baseUrl}${API.takeFacultyAttendane}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'latitude': "",
          'longitude': "",
          'faculty_id': branch,
        }),
      );

      if (response.statusCode == 200) {
        print('Push notification sent successfully');
      } else {
        print('Failed to send push notification: ${response.body}');
      }
    } catch (e) {
      print('Error sending push notification: $e');
    }
  }
}
