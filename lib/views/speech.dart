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
    userController.userInput.text = "";
  }

  @override
  Widget build(BuildContext context) {
        double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    String message = "Enter you Text here";
    return Scaffold(
      backgroundColor: Color.fromARGB(255,35,37,49),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
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
              child: Text("Generate Notes",style: TextStyle(fontFamily: 'man-r',fontSize: 18,color: Colors.white),),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,),
        backgroundColor: Color.fromARGB(255,35,37,49),
        title: Text("Record Lecture",style: TextStyle(fontFamily: 'man-r',fontSize: 20, color: Colors.white),),
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
                  color: const Color.fromARGB(60, 255, 255, 255)
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic,color: Color.fromARGB(255, 255, 255, 255),size: 50,),
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
            ),
            
            SizedBox(height: 100,),
            Container(
              width: w,
              height: 200,
              padding: EdgeInsets.all(20),
              child: Text(userController.userInput.text.toString(), style: TextStyle(color: Colors.white, fontFamily: 'man-r'),),
            )
          ],
        ),
      ),
    );
  }
}