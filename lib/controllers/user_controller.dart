import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:prototype/views/auth/signup.dart';
import 'package:prototype/views/home.dart';
import 'package:prototype/views/tabs/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


class UserController extends GetxController{

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userInput = TextEditingController();
  var isLoading = false.obs;
  var username;
  var useremail;
  TextEditingController url = TextEditingController();
  

  Future<void> signUpWithEmailPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      User? user = userCredential.user;
      if(kDebugMode) print('User signed up: ${user!.uid}');
      await registerUser(user?.uid);
    } catch (e) {
      if(kDebugMode) print('Error signing up: $e');
      Fluttertoast.showToast(
        msg: "User Already Exists",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
      );
    }
  }


  Future<void> registerUser(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final ref = await firestore.collection('users').doc(id).set({
        'email': email.text,
        'name': name.text,
        'password': password.text,
      });
      prefs.setString("uid", id);
      if(kDebugMode) print('User data stored successfully');
      Get.to(Home(),transition: Transition.downToUp,duration: 200.milliseconds);
    }catch(e){
      if(kDebugMode) print('Error storing user data: $e');
    }
  }
  
  Future<void> signInWithEmailPassword() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    
    User? user = userCredential.user;
    if(kDebugMode) print('User signed in: ${user!.uid}');
    Get.to(Home(),transition: Transition.downToUp,duration: 200.milliseconds);
   
  } catch (e) {
    if(kDebugMode) print('Error signing in: $e');
    Fluttertoast.showToast(
      msg: e.toString(),
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
    );
    
  }



}

  Future<void> getUser() async{
    isLoading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final ref = await FirebaseFirestore.instance
        .collection("users")
        .doc(prefs.getString('uid'))
        .get();

    Map<String, dynamic>? userData = ref.data();
    username = userData?["name"];
    useremail = userData?["useremail"];

  }

  Future<void> logout() async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    Get.to(SignUp(),transition: Transition.leftToRight, duration: 200.milliseconds);
  }


//   Future<void> _downloadPdf() async {
//   final response = await http.get(Uri.parse('http://your-flask-backend.com/generate_pdf'));
//   final bytes = response.bodyBytes;
//   final pdfFile = await _saveFile(bytes, 'output.pdf');
//   // Display the PDF file
// }

// Future<File> _saveFile(Uint8List bytes, String filename) async {
//   final directory = await getApplicationDocumentsDirectory();
//   final file = await directory.createFile(filename);
//   await file.writeAsBytes(bytes);
//   return file;
// }

  Future<void> createNotes() async{
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading(true);
    print("sent create notes request --------------------------------");
    try{
      String url = "${prefs.getString("url")}/generatePDF";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['text'] = userInput.text.toString();
    
      var res = await request.send();

      if(res.statusCode == 200){
        print("Upload Succesfully");
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

    }catch(e){
      print(e);

    }   
    isLoading(false); 
  }



  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('assets/phone.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(
        pw.Page(
            margin: const pw.EdgeInsets.all(10),
            pageFormat: PdfPageFormat.a4,
            build: (context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Header(text: "About Cat", level: 1),
                        pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.fitHeight, height: 100, width: 100)
                      ]
                    ),
                    pw.Divider(borderStyle: pw.BorderStyle.dashed),
                    pw.Paragraph(text: "This it sample text"),
                  ]
              );
            }
        ));
    return pdf.save();
  }
  
  



} 


