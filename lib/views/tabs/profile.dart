import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prototype/controllers/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  UserController userController = Get.put(UserController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255,35,37,49),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
                        onTap: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("url",userController.url.text.toString());
                        },
                        child: Container(
                          width: w,
                          height: h * 0.06,
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black
                          ),
                          child: Center(
                            child: Text("Save",style: TextStyle(fontFamily: 'man-r',fontSize: 18,color: Colors.white
                            ),),
                          ),
                        ),
                      ),
      ),

      appBar: AppBar(backgroundColor: Color.fromARGB(255,35,37,49),title: Text("Profile", style: TextStyle(fontFamily: 'man-r', color: Colors.white),)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  width: w,
                  height: h * 0.63,
                  
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: AssetImage("images/person.png")
                            )
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("Hemanth Srinivas",style: TextStyle(fontFamily: 'man-r',fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),),
                        SizedBox(height: 10,),
                        Text("shemanth2003.vskp@gmail.com",style: TextStyle(fontFamily: 'man-r',fontSize: 16,color: Colors.white),),
                        SizedBox(height: h * 0.2,),
                        
          
                      ],
                    ),
                  ),
                ),
                Padding(
                      padding: const EdgeInsets.all(12.0),
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
                                  controller : userController.url,
                                  keyboardType: TextInputType.emailAddress,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  style: const TextStyle(fontFamily: 'man-r',color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: "URL",
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
                    
              ],
            ),
          ),
        ),
      ),
    );
  }
}