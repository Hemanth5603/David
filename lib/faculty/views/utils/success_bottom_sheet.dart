import 'package:flutter/material.dart';

class SuccessBottomSheet extends StatelessWidget {
  SuccessBottomSheet(
      {super.key,
      required this.successMessage,
      required this.onPressed,
      required this.buttonText,
      required this.textColor});

  String successMessage;
  String buttonText;
  final VoidCallback onPressed;
  Color textColor;

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
                    color: const Color.fromARGB(255, 238, 238, 238)),
                child: Center(child: Icon(Icons.check_rounded)),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  successMessage,
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'man-b',
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              onPressed(); // Invoke the onPressed function
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  buttonText,
                  style: const TextStyle(
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
