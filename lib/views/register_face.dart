import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/controllers/register_face_controller.dart';
import 'package:prototype/views/utils/image_viewer.dart';

class RegisterFace extends StatefulWidget {
  @override
  _RegisterFaceState createState() => _RegisterFaceState();
}

class _RegisterFaceState extends State<RegisterFace> {
  late CameraController controller;
  late CameraDescription cameraDescription;
  String capturedImage = "";
  bool show = false;
  RegisterFaceController registerFaceController = Get.put(RegisterFaceController());

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    Future.delayed(Duration(seconds: 1),(){
      setState(() {
        show = true;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      cameraDescription = await availableCameras().then((value) => value.firstWhere((element) => element.lensDirection == CameraLensDirection.front));
      if (cameraDescription != null) {
        controller = CameraController(cameraDescription, ResolutionPreset.high);
        controller.initialize().then((value) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
    } on CameraException catch (e) {
      print(e.code);
      print(e.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          show == false ? Container(
            width: w,
            height: h * 0.8,
            color: Colors.black,
          ) :Container(
            width: w,
            height: h * 0.8,
            child: CameraPreview(controller),
          ),
          GestureDetector(
            onTap: () {
              _takePicture(registerFaceController);
            },
            child: Container(
              width: w,
              height: h * 0.2,
              color: Color.fromARGB(255, 0, 0, 0),
              child: Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white, width: 5)
                  ),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color:  Colors.white
                      ),
                    ),
                  ),
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  void _takePicture(registerController) async {
    try {
      //final path = '${Directory.systemTemp.path}/image.png';
      XFile file =  await controller.takePicture();
      capturedImage = file.path;
      registerFaceController.filePath = file.path;
      print(registerFaceController.filePath);
      /*showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Image.file(File(capturedImage)),
        ),
      );*/
      Get.to(ImageViewer(path: capturedImage));
    } on CameraException catch (e) {
      print(e.code);
      print(e.description);
    }
  }
}