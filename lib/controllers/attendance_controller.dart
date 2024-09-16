import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/constants.dart';
import 'package:prototype/models/roll_no.dart';
import 'package:prototype/models/student_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController extends GetxController{

  var isLoading = false.obs;
  String videoPath = "";
  String filePath = "";
  AttendanceResponseModel? attendanceResponseModel;
  StudentModel? studentModel;

  Future<void> takeAttendance() async{
    isLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
   
    String url = "${prefs.getString("url")}/upload-video/";
    print("url -------------------------------------------------------- -- $url");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    print(videoPath);
    request.files.add(await http.MultipartFile.fromPath('video',videoPath));

    //request.files.add(http.MultipartFile.fromBytes('video', File(file.path).readAsBytesSync(),filename: file.path));
    //http.StreamedResponse response = await request.send();
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if(response.statusCode == 200){
      print("Upload Succesfully");
      var data = jsonDecode(response.body.toString());
      attendanceResponseModel = AttendanceResponseModel.fromJson(data);
      print("${data.toString()} ------------------------------------------------------------------------------------------------");
      Fluttertoast.showToast(
          msg: "Upload Succesfully",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 82, 244, 54)
        );  
    }else{
      print("Could not upload Succesfully ${response.statusCode}");
      Fluttertoast.showToast(
          msg: "Could not upload Succesfully",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red
        );
    }
    isLoading(false);
   
  }


  Future<StudentModel?> findFace(String path) async {
  isLoading(true);
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //String url = "${prefs.getString("url")}/david/findface";
    String url = "http://13.60.93.136:8080/david/findface";
   
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
      studentModel = StudentModel.fromJson(json);
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


}