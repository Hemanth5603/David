import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/controllers/user_controller.dart';
import 'package:speech_to_text/speech_to_text.dart';
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
  String words = "";
  
  bool isListening = false;

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      isListening = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      isListening = false;
    });
    print(userController.userInput.text.toString());
  }
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      userController.userInput.text = result.recognizedWords;
    });
    print(userController.userInput.text.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeech();
  }

  @override
  Widget build(BuildContext context) {
        double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    String message = "Enter you Text here";
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: (){

        },
        child: Container(
          width: w,
          height: h * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black
          ),
          child: Center(
            child: Text("Generate Notes..",style: TextStyle(fontFamily: 'man-r',fontSize: 18,color: Colors.white),),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Record Lecture",style: TextStyle(fontFamily: 'man-r',fontSize: 20),),
      ),
      body: SafeArea(
        child: Center(
          child: IconButton(
            icon: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic,color: const Color.fromARGB(255, 0, 0, 0),size: 50,),
            onPressed: (){
              setState(() {
                  print("Called");
                  message = "Listening your voice...";
                  _speechToText.isNotListening ? _startListening() : _stopListening();
                  userController.userInput.text = "";
                });
            },
          ),
        ),
      ),
    );
  }
}