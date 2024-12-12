import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/api.dart';
import 'package:prototype/constants.dart';
import 'package:prototype/faculty/models/find_face_response.dart';
import 'package:prototype/faculty/models/roll_no.dart';
import 'package:prototype/faculty/models/student_model.dart';
import 'package:prototype/faculty/views/auth/login.dart';
import 'package:prototype/faculty/views/faculty_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController extends GetxController {
  var isLoading = false.obs;
  String videoPath = "";
  String filePath = "";
  AttendanceResponseModel? attendanceResponseModel;
  // FindfaceResponse? studentModel;
  FindFaceResponse? findFaceResponse;

  Future<void> takeAttendance() async {
    isLoading(true);
    await Future.delayed(Duration(seconds: 5));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String branch = prefs.getString("fbranch") ?? 'CSE';

    String url = "${API.mlurl}${API.attendance}";
    print(
        "url -------------------------------------------------------- -- $url");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    print(videoPath);
    request.files.add(await http.MultipartFile.fromPath('video', videoPath));
    request.fields['branch'] = "CSE";
    //request.fields['section'] = "C";

    //request.files.add(http.MultipartFile.fromBytes('video', File(file.path).readAsBytesSync(),filename: file.path));
    //http.StreamedResponse response = await request.send();
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);

    if (response.statusCode == 200) {
      print("Upload Succesfully");
      var data = jsonDecode(response.body.toString());
      attendanceResponseModel = AttendanceResponseModel.fromJson(data);
      for (int i = 0; i < attendanceResponseModel!.presents.length; i++) {
        print(attendanceResponseModel!.presents[i].toString());
      }
      print(
          "${data.toString()} ------------------------------------------------------------------------------------------------");
      Fluttertoast.showToast(
          msg: "Upload Succesfully",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 82, 244, 54));
    } else {
      print("Could not upload Succesfully ${response.statusCode}");
      Fluttertoast.showToast(
          msg: "Could not upload Succesfully",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red);
    }
    isLoading(false);
  }

  Future<FindFaceResponse?> findFace(String path) async {
    isLoading(true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //String url = "${prefs.getString("url")}/david/findface";
      String url = "${API.mlurl}${API.mlfindface}";
      print(url);

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('image', path));

      var res = await request.send();

      if (res.statusCode == 200) {
        // Read and parse the response from the server
        var responseBody = await res.stream.bytesToString();

        if (kDebugMode) {
          print("Data Upload Successful...");
          print("Response: $responseBody");
        }

        // Parse response body as JSON and create a StudentModel instance
        Map<String, dynamic> json = jsonDecode(responseBody);
        findFaceResponse = FindFaceResponse.fromJson(json);
      } else {
        if (kDebugMode) {
          print("Upload Unsuccessful");
          print("Response Code: ${res.statusCode}");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) print(e);
    } finally {
      isLoading(false);
    }
    return null;
  }

  Future<String> AIloginFaculty(String path) async {
    isLoading(true);
    try {
      print("Called AI login ------------------/////////////");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //String url = "${prefs.getString("url")}/david/findface";
      String url = "${API.mlurl}${API.mlfindface}";
      print(url);

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('image', path));

      var res = await request.send();
      print(
          "------------------------------------------------------------------${res.statusCode}");
      if (res.statusCode == 200) {
        // Read and parse the response from the server
        var responseBody = await res.stream.bytesToString();

        Get.to(FacultyHome());

        if (kDebugMode) {
          print("Data Upload Successful...");
          print("Response: $responseBody");
        }

        // Parse response body as JSON and create a StudentModel instance
        Map<String, dynamic> json = jsonDecode(responseBody);
        findFaceResponse = FindFaceResponse.fromJson(json);
        return "";
      } else {
        if (kDebugMode) {
          print("Upload Unsuccessful");
          print("Response Code: ${res.statusCode}");
        }
        return "No Face Found!!";
      }
    } catch (e) {
      if (kDebugMode) print(e);
    } finally {
      isLoading(false);
    }
    return "No Face Found !!";
  }
}
