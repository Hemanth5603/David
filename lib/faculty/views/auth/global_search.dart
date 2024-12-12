import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:prototype/faculty/controllers/attendance_controller.dart';
import 'package:prototype/faculty/controllers/camera_controller.dart';
import 'package:prototype/faculty/views/attendance/response_page.dart';
import 'package:prototype/faculty/views/utils/error_bottom_sheet.dart';
import 'package:prototype/faculty/views/utils/find_face_image_viewer.dart';
import 'package:prototype/faculty/views/utils/success_bottom_sheet.dart';

class GlobalSearch extends StatefulWidget {
  @override
  State<GlobalSearch> createState() => _GlobalSearchState();
}

class _GlobalSearchState extends State<GlobalSearch> {
  String capturedImage = "";
  bool isZoomed = false;
  bool show = true;

  final Camera camera = Get.put(Camera());
  AttendanceController attendanceController = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: h,
            color: Colors.black,
          ),
          Obx(
            () => attendanceController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Positioned(
                    child: SizedBox(
                      height: h * 0.8,
                      width: 1000,
                      child: GestureDetector(
                          // onScaleUpdate: (details) {
                          //   double newZoomLevel = camera.zoomLevel.value *
                          //       (1 + (details.scale - 1) * 0.07);
                          //   newZoomLevel = newZoomLevel.clamp(
                          //     camera.minZoomLevel.value,
                          //     camera.maxZoomLevel.value,
                          //   );
                          //   camera.setZoom(newZoomLevel);
                          // },
                          child: CameraPreview(camera.cameraController)),
                    ),
                  ),
          ),
          Positioned(
            top: h * 0.8,
            child: GestureDetector(
              onTap: () {
                _takePicture(camera, context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: h * 0.2,
                color: const Color.fromARGB(255, 0, 0, 0),
                child: Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: h * 0.22,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(34, 0, 0, 0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // IconButton(
                  //   icon: Icon(Icons.switch_camera),
                  //   color: Colors.white,
                  //   onPressed: () {
                  //     camera
                  //         .toggleCameraLens(); // Assuming this method exists in your camera controller
                  //   },
                  // ),
                  GestureDetector(
                    onTap: () {
                      double newZoomLevel = camera.minZoomLevel.value;
                      newZoomLevel = newZoomLevel.clamp(
                        camera.minZoomLevel.value,
                        camera.maxZoomLevel.value,
                      );
                      camera.setZoom(newZoomLevel);
                      setState(() {
                        isZoomed = false;
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: !isZoomed
                            ? Colors.white
                            : const Color.fromARGB(68, 255, 255, 255),
                      ),
                      child: const Center(
                        child: Text(
                          "1x",
                          style: TextStyle(
                              fontFamily: 'man-r',
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!isZoomed) {
                        double newZoomLevel = camera.zoomLevel.value * 2;
                        newZoomLevel = newZoomLevel.clamp(
                          camera.minZoomLevel.value,
                          camera.maxZoomLevel.value,
                        );
                        camera.setZoom(newZoomLevel);
                        setState(() {
                          isZoomed = true;
                        });
                      }
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: isZoomed
                            ? Colors.white
                            : const Color.fromARGB(68, 255, 255, 255),
                      ),
                      child: const Center(
                        child: Text(
                          "2x",
                          style: TextStyle(
                              fontFamily: 'man-r',
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _takePicture(Camera camera, context) async {
    try {
      XFile file = await camera.cameraController.takePicture();
      capturedImage = file.path;
      attendanceController.filePath = file.path;

      // Save the image to the gallery
      final Uint8List imageData = await file.readAsBytes();
      print(capturedImage);
      String err = await attendanceController.GlobalSearch(capturedImage);
      if (err != "") {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return ErrorBottomSheet(
                error: "Unauthorized Access",
              );
            });
      } else {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return SuccessBottomSheet(
                successMessage: "Found Candidate !!",
                onPressed: () => Get.back(),
                buttonText: "Get Back",
                textColor: Colors.green,
              );
            });
      }
      // Get.to(
      //   FindFaceImageViewer(path: capturedImage),
      //   transition: Transition.rightToLeft,
      //   duration: 300.milliseconds,
      // );
    } on CameraException catch (e) {
      if (kDebugMode) print(e.code);
      if (kDebugMode) print(e.description);
    }
  }
}
