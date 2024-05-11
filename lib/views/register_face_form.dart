import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/controllers/register_face_controller.dart';
import 'package:prototype/views/register_face.dart';

class RegisterFaceForm extends StatefulWidget {
  const RegisterFaceForm({super.key});

  @override
  State<RegisterFaceForm> createState() => _RegisterFaceFormState();
}

class _RegisterFaceFormState extends State<RegisterFaceForm> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    RegisterFaceController registerFace = Get.put(RegisterFaceController());

    return Scaffold(
      bottomNavigationBar:  GestureDetector(
        onTap: (){
          registerFace.registerFace();
        },
        child: Container(
                      width: w,
                      height: h * 0.06,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black
                      ),
                      child:Obx(() => registerFace.isLoading.value ? Center(child: CircularProgressIndicator(),)  :Center(
                        child: Text("Register User ",style: TextStyle(fontFamily: 'man-r',fontSize: 18,color: Colors.white
                        ),)
                      ))
                    ),
      ),
      appBar: AppBar(
        title: Text("Register New Face",style: TextStyle(fontSize: 20,fontFamily:'man-sb'),),
      ),
      body:SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            
            children: [
              SizedBox(height: h * 0.02,),
              Container(
                width: w,
                height: h * 0.05,
                margin: EdgeInsets.only(left: 10),
                child: Text("Enter Details...",style: TextStyle(fontFamily: 'man-sb',fontSize: 25),),
            ),
              Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: Container(
                      height: 45,
                      width: w,
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            height: h * 0.12,
                            width: w* 0.8,
                            child:  Center(
                              child: TextField(
                                controller : registerFace.name,
                                keyboardType: TextInputType.emailAddress,
                                textAlignVertical: TextAlignVertical.bottom,
                                style: const TextStyle(fontFamily: 'man-r'),
                                decoration: const InputDecoration(
                                  hintText: "Name",
                                  hintStyle: TextStyle(color: Color.fromARGB(255, 106, 106, 106)),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Container(
                      height: 45,
                      width: w,
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          SizedBox(
                            height: h * 0.12,
                            width: w* 0.8,
                            child:  Center(
                              child: TextField(
                                controller : registerFace.roll,
                                keyboardType: TextInputType.emailAddress,
                                textAlignVertical: TextAlignVertical.bottom,
                                style: const TextStyle(fontFamily: 'man-r'),
                                decoration: const InputDecoration(
                                  hintText: "Roll No.",
                                  hintStyle: TextStyle(color: Color.fromARGB(255, 106, 106, 106)),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.05,),
                  GestureDetector(
                    onTap: (){
                      Get.to(RegisterFace(),transition: Transition.downToUp, duration: 200.milliseconds);
                    },
                    child: Container(
                      width: w,
                      height: h * 0.06,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black
                      ),
                      child: Center(
                        child: Text("Click your Picture 📷",style: TextStyle(fontFamily: 'man-r',fontSize: 18,color: Colors.white
                        ),),
                      )
                    ),
                  ),
                  Text(registerFace.filePath,style: TextStyle(fontSize: 10,fontFamily: 'man-l'),)
            ],
          ),
        )
      ),
    );
  }
}