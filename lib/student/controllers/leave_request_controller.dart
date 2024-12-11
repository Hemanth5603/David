import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:prototype/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LeaveRequestController extends GetxController {
  Future<void> sendLeaveRequest(admin, incharge, subject, reason) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name") ?? 'Hemanth';
    String branch = prefs.getString("branch") ?? 'CSE';
    String roll = prefs.getString("roll") ?? '20CSE1001';

    try {
      final response = await http.post(
        Uri.parse('${API.baseUrl}${API.sendLeaveRequest}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'branch': branch,
          'roll': roll,
          'class_incharge': incharge,
          'admin_name': admin,
          'subject': subject,
          'reason': reason,
          'status': 1
        }),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Requested Succesfully",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 82, 244, 54));
      } else {
        print('Failed to send LEave request: ${response.body}');
      }
    } catch (e) {
      print('Error sending leave request: $e');
    }
  }
}
