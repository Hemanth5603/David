import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:prototype/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SpeechController extends GetxController {
  Future<String> convertSpeech(String speech) async {
    try {
      print("Called-------------------------------------------");
      print(speech);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString("fid") ?? '1';
      String branch = prefs.getString("fbranch") ?? 'CSE';

      String url = '${API.mlurl}${API.generateNotes}';

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['text'] = speech;
      request.fields['faculty_id'] = id;
      request.fields['branch'] = branch;

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();

        if (kDebugMode) {
          print("Data Upload Successful...");
          print("Response: $responseBody");
        }

        // Parse response body as JSON and create a StudentModel instance
        Map<String, dynamic> json = jsonDecode(responseBody);
        print(json);
        return "";
      } else {
        return 'Cant trans ';
      }
    } catch (e) {
      print(e);
    }
    return "Cant transcrible Lecture";
  }

  jsonEncode(Map<String, String> map) {}
}
