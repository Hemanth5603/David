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

  Future<String> takeFacultyAttendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String branch = prefs.getString("fid") ?? '1';
    try {
      final response = await http.post(
        Uri.parse('${API.baseUrl}${API.takeFacultyAttendane}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'latitude': 28.4629043,
          'longitude': 77.4881184,
          'faculty_id': 1,
        }),
      );

      if (response.statusCode == 200) {
        return "";
      } else {
        return 'Cant approve Attendance : ${response.body}';
      }
    } catch (e) {
      return 'Cant approve attendance: $e';
    }
  }
}
