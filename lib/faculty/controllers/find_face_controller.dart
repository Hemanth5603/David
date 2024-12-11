import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:prototype/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FindFaceController extends GetxController {
  String filePath = "";
  var isLoading = false.obs;

  Future<void> findFace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading(true);
    print("Register face called --------------------------------");
    try {
      String url = "${API.mlurl}${API.mlfindface}";
      print(url);
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('image', filePath));
      //request.files.add(await http.MultipartFile.fromBytes('Image', File(filePath).readAsBytesSync(),filename: filePath));
      var res = await request.send();

      if (res.statusCode == 200) {
        print("Upload Succesfully");
        Fluttertoast.showToast(
            msg: "Upload Succesfully",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 62, 255, 56));
      } else {
        print("Could not upload Succesfully");
        Fluttertoast.showToast(
            msg: "Could not upload Succesfully",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e);
    }
    isLoading(false);
  }
}
