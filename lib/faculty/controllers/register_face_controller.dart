import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterFaceController extends GetxController{

  TextEditingController name = TextEditingController();
  TextEditingController roll = TextEditingController();
  String filePath = "";
  var isLoading = false.obs;


  Future<void> registerFace() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading(true);
    print("Register face called --------------------------------");
    try{
      String url = "${prefs.getString("url")}/register-face/";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      //request.fields['Name'] = name.text.toString();
      print(name.text);
      print(roll.text);
      print(filePath);
      request.files.add(await http.MultipartFile.fromPath('face',filePath));
      request.fields['roll'] = roll.text.toString().toUpperCase();
      //request.files.add(await http.MultipartFile.fromBytes('Image', File(filePath).readAsBytesSync(),filename: filePath));
      var res = await request.send();

      if(res.statusCode == 200){
        print("Upload Succesfully");
        Fluttertoast.showToast(
          msg: "Upload Succesfully",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color.fromARGB(255, 62, 255, 56)
        );  
      }else{
        print("Could not upload Succesfully");
        Fluttertoast.showToast(
          msg: "Could not upload Succesfully",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red
        );
      }

    }catch(e){
      print(e);

    }   
    isLoading(false); 
  }

}