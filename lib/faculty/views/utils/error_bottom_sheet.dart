import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ErrorBottomSheet extends StatelessWidget {
  ErrorBottomSheet({super.key, required this.error});

  String error;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 201, 201, 201)),
                child: Center(
                  child: Icon(
                    Icons.error_rounded,
                    color: Color.fromARGB(255, 253, 45, 22),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                child: Text(
                  error,
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'man-b',
                      color: Color.fromARGB(255, 255, 67, 67),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Spacer(), // Push the bottom container to the bottom
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  'Go Back !',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'man-sb',
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
