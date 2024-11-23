import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/controllers/attendance_controller.dart';
import 'package:prototype/views/attendance/video_page.dart';

class VideoRecordPage extends StatefulWidget {
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
  double initialY = 0.0;

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
    Future.delayed(Duration(seconds: 1), () {
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

  _onLongPressStart(LongPressStartDetails details) {
    initialY = details.globalPosition.dy;
    _recordVideo();
  }

  _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) async {
    double verticalMovement = initialY - details.globalPosition.dy;
    double maxZoomLevel = await cameraController.getMaxZoomLevel();
    double newZoomLevel = zoomLevel + (verticalMovement / 1500);

    // Clamp the zoom level between 1 and the maximum available zoom level
    newZoomLevel = newZoomLevel.clamp(1.0, maxZoomLevel);

    setState(() {
      zoomLevel = newZoomLevel;
    });

    cameraController.setZoomLevel(zoomLevel);
  }

  _onLongPressEnd(LongPressEndDetails details) {
    _recordVideo();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          show == false
              ? Container(
                  width: w,
                  height: h * 0.9,
                )
              : GestureDetector(
                  child: Stack(
                    children: [
                      Container(
                        height: h * 0.9,
                        child: CameraPreview(cameraController),
                      ),
                      Positioned(
                        top: h * 0.8,
                        left: w / 2 - 35,
                        child: GestureDetector(
                          onLongPressStart: _onLongPressStart,
                          onLongPressMoveUpdate: _onLongPressMoveUpdate,
                          onLongPressEnd: _onLongPressEnd,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            child: Center(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color:
                                      isRecording ? Colors.blue : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
          Container(
            width: w,
            height: h * 0.1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
