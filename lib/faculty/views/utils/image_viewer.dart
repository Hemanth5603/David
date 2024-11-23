import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/faculty/views/auth/register_face_form.dart';

class ImageViewer extends StatefulWidget {
  String path;
  ImageViewer({
    super.key,
    required this.path,
  });

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title:  Text('Confirm Your Profile Image',style: TextStyle(fontSize: 18,fontFamily: 'man-sb',color: Colors.black,),)),
      body: Column(
        children: [
          Container(
            
              width: w,
              height: h * 0.82,
              child: Image.file(File(widget.path)),
            
          ),
          GestureDetector(
        onTap: (){
          Get.off(RegisterFaceForm(),transition: Transition.leftToRight, duration: 200.milliseconds);
        },
        child: Container(
          width: w,
          height: h * 0.079,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Center(
            child: Text("Confirm Image",style: TextStyle(fontFamily: 'man-r',fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
          ),
        ),
      ),
        ],
      ),
    );
  }
}