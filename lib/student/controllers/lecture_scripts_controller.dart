import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:prototype/api.dart';
import 'package:prototype/student/models/lecture_script_model.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/student/views/components/lecture_scripts.dart';

class LectureScriptsController extends GetxController {
  Rx<LectureScript?> lectureScript = Rx<LectureScript?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchScripts();
  }

  void fetchScripts() async {
    try {
      isLoading.value = true;

      // Make the API call to your backend
      final response = await http.get(
        Uri.parse('${API.baseUrl}${API.fetchscripts}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        lectureScript.value = LectureScript.fromJson(responseData);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Fluttertoast.showToast(
          msg: "Failed to fetch lecture scripts",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
        );
        return null;
      }
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) print('Failed to fetch lecture scripts: $e');
      Fluttertoast.showToast(
        msg: "An error occurred during login",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
      );
      return null;
    }
  }
}
