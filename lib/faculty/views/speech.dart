import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/faculty/controllers/speech_controller.dart';
import 'package:prototype/faculty/controllers/user_controller.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class Speech extends StatefulWidget {
  const Speech({super.key});

  @override
  State<Speech> createState() => _SpeechState();
}

class _SpeechState extends State<Speech> {
  UserController userController = Get.put(UserController());
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool isListening = false;
  bool _shouldContinueListening = false;
  Timer? _restartTimer;
  final SpeechController speechController = Get.put(SpeechController());

  Future<void> _initSpeech() async {
    try {
      _speechEnabled = await _speechToText
          .initialize(onError: (error) => _handleError(error), options: [
        SpeechConfigOption("android", "continuous", "true"),
      ]);
      setState(() {});
    } catch (e) {
      print('Error initializing speech: $e');
    }
  }

  void _handleError(dynamic error) {
    print('Speech recognition error: $error');
    if (_shouldContinueListening && mounted) {
      _restartTimer?.cancel();
      _restartTimer = Timer(Duration(seconds: 1), () {
        if (_shouldContinueListening && mounted) {
          _startListening();
        }
      });
    }
  }

  void _startListening() async {
    if (!_speechEnabled) {
      await _initSpeech();
    }

    _shouldContinueListening = true;
    try {
      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenFor: const Duration(hours: 1),
        pauseFor: Duration(minutes: 5),
        partialResults: true,
        listenMode: ListenMode.dictation,
        cancelOnError: false,
        onSoundLevelChange: (level) {
          // Can be used to show visual feedback
        },
      );

      setState(() {
        isListening = true;
      });
    } catch (e) {
      print('Error starting listening: $e');
      _handleError(e);
    }
  }

  void _stopListening() async {
    _shouldContinueListening = false;
    _restartTimer?.cancel();
    try {
      await _speechToText.stop();
      setState(() {
        isListening = false;
      });
      print('Final text: ${userController.userInput.text}');
    } catch (e) {
      print('Error stopping listening: $e');
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (mounted) {
      setState(() {
        if (result.finalResult) {
          String currentText = userController.userInput.text;
          String separator = currentText.isEmpty ? '' : ' ';
          userController.userInput.text =
              currentText + separator + result.recognizedWords;

          if (_shouldContinueListening && !_speechToText.isListening) {
            _restartTimer?.cancel();
            _restartTimer = Timer(Duration(milliseconds: 50), () {
              if (_shouldContinueListening && mounted) {
                _startListening();
              }
            });
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
    userController.userInput.text = "";
  }

  @override
  void dispose() {
    _stopListening();
    _restartTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 37, 49),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () async {
            await speechController.convertSpeech(userController.userInput.text);
          },
          child: Container(
            width: w,
            height: h * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.black),
            child: Center(
              child: Text(
                "Generate Notes",
                style: TextStyle(
                    fontFamily: 'man-r', fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 35, 37, 49),
        title: Text(
          "Record Lecture",
          style:
              TextStyle(fontFamily: 'man-r', fontSize: 20, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromARGB(60, 255, 255, 255)),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 50,
                    ),
                    onPressed: () {
                      if (_speechToText.isNotListening) {
                        userController.userInput.text = "";
                        _startListening();
                      } else {
                        _stopListening();
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 100),
            Container(
              width: w,
              height: 200,
              padding: EdgeInsets.all(20),
              child: Text(
                userController.userInput.text,
                style: TextStyle(color: Colors.white, fontFamily: 'man-r'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
