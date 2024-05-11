import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/constants.dart';
import 'package:prototype/models/roll_no.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController extends GetxController{

  var isLoading = false.obs;
  String videoPath = "";
  RollModel? rollModel;

  Future<void> takeAttendance() async{
     isLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
   
    String url = "${prefs.getString("url")}/uploadDetailedVideo";
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
      rollModel = RollModel.fromJson(data);
      print("${data.toString()} ------------------------------------------------------------------------------------------------");
      Fluttertoast.showToast(
          msg: "Upload Succesfully",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red
        );  
    }else{
      print("Could not upload Succesfully");
      Fluttertoast.showToast(
          msg: "Could not upload Succesfully",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red
        );
    }
    isLoading(false);
  }
}