import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/controllers/attendance_controller.dart';
import 'package:prototype/views/response_page.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  VideoPage({
    super.key,
    this.filePath,
  });
  String? filePath;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController videoController;
  AttendanceController attendanceController = Get.put(AttendanceController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoController.dispose();
  }

  Future _initVideoPlayer() async{
    videoController = VideoPlayerController.file(File(widget.filePath!));
    await videoController.initialize();
    await videoController.setLooping(false);
    await videoController.play();
  }

 @override
Widget build(BuildContext context) {
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;
  return Scaffold(
    bottomNavigationBar: GestureDetector(
      onTap: (){
        attendanceController.takeAttendance();
        Get.to(ResponsePage(),transition: Transition.rightToLeft, duration: 200.milliseconds);
      },
      child: Container(
        width: w,
        height: h * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.black,
        ),
        child: Center(
          child: Text("Take Attendance",style: TextStyle(fontFamily: 'man-r',color: Colors.white),),
        ),
      ),
    ),
    appBar: AppBar(
      title: const Text('Preview'),
      elevation: 0,
      backgroundColor: Colors.black26,
      actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: () {
            print('do something with the file');
          },
        )
      ],
    ),
    extendBodyBehindAppBar: true,
    body: FutureBuilder(
      future: _initVideoPlayer(),
      builder: (context, state) {
        if (state.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return VideoPlayer(videoController);
        }
      },
    ),
  );

}
}