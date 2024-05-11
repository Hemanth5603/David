import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/controllers/attendance_controller.dart';
import 'package:prototype/views/video_page.dart';

class VideoRecordPage extends StatefulWidget {
  VideoRecordPage({
    super.key,
  });

  @override
  State<VideoRecordPage> createState() => _VideoRecordPageState();
}

class _VideoRecordPageState extends State<VideoRecordPage> {
  bool isLoading = true;
  bool isRecording = false;
  late CameraController cameraController;
  double zoomLevel = 1;
  bool show = false;
  AttendanceController attendanceController = Get.put(AttendanceController());

  void initCameras() async {
    final cameras = await availableCameras();
    final back = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
    cameraController = CameraController(back, ResolutionPreset.max);
    await cameraController.initialize();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCameras();
    Future.delayed(Duration(seconds: 1),(){
      setState(() {
        show = true;
      });
    });
  }

  _recordVideo() async {
    if (isRecording) {
      final file = await cameraController.stopVideoRecording();
      setState(() => isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(filePath: file.path),
      );
      attendanceController.videoPath = file.path;
      Navigator.push(context, route);
    } else {
      await cameraController.prepareForVideoRecording();
      await cameraController.startVideoRecording();
      setState(() => isRecording = true);
    }
  }

  _onScaleStart(ScaleStartDetails details) {
    zoomLevel = 1;
  }

  _onScaleUpdate(ScaleUpdateDetails details) {
    zoomLevel *= details.scale;
    cameraController.setZoomLevel(zoomLevel);
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
          ) : GestureDetector(
            onScaleUpdate: _onScaleUpdate,
            child: Container(
              height: h * 0.8,
              child: CameraPreview(cameraController),
            ),
          ),
          GestureDetector(
            onTap: () {
              _recordVideo();
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
                        color: isRecording ? Colors.blue : Colors.white
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
}