import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/constants.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  get notifications => null;

  @override
  void onInit() {
    super.onInit();
    //initFirebaseMessaging();
  }

  Future<void> initFirebaseMessaging() async {
    // Request permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get FCM token
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    // Handle incoming messages when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> sendPushNotification(String title, String description) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}send-notification'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': title,
          'description': description,
          'topic': 'all',
        }),
      );

      if (response.statusCode == 200) {
        print('Push notification sent successfully');
      } else {
        print('Failed to send push notification: ${response.body}');
      }
    } catch (e) {
      print('Error sending push notification: $e');
    }
  }

  Future<void> createNotification(String title, String description) async {
    try {
      isLoading(true);

      final Map<String, dynamic> notificationData = {
        'title': title,
        'description': description,
        'notification_type': "faculty",
        'creator': "Hemanth",
        'status': "active",
        'creator_image': null
      };

      print("Request body: ${jsonEncode(notificationData)}");
      print("${Constants.baseUrl}admin/create-notification");

      final response = await http.post(
        Uri.parse("${Constants.baseUrl}admin/create-notification"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(notificationData),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Send push notification after successful creation
        await sendPushNotification(title, description);

        Fluttertoast.showToast(
          msg: "Notification created successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: response.body,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(
        msg: "An error occurred. Please check your connection.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}
