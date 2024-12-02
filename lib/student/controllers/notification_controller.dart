import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/constants.dart';
import 'package:prototype/services/auth_service.dart';
import 'dart:convert';
import '../models/notification_model.dart';

class StudentNotificationController extends GetxController {
  Rx<NotificationModel?> notifications = Rx<NotificationModel?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;

      // Replace with your actual API endpoint
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}user/get-all-notifications'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        notifications.value = NotificationModel.fromJson(data);
        await AuthService.to.loginAsStudent();
        Get.offAllNamed('/student/home');
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      // You can add proper error handling here
    } finally {
      isLoading.value = false;
    }
  }

  // Method to refresh notifications
  Future<void> refreshNotifications() async {
    await fetchNotifications();
  }
}
