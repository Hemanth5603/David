import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../api.dart';
import '../models/assignment_model.dart';

class AssignmentController extends GetxController {
  final Rx<AssignmentModel?> assignments = Rx<AssignmentModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  Future<void> fetchAssignments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String branch = prefs.getString("branch") ?? 'CSE';
    try {
      isLoading.value = true;
      error.value = '';

      final response = await http.get(
        Uri.parse('${API.baseUrl}${API.getAssignments}$branch'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        assignments.value = AssignmentModel.fromJson(data);
      } else {
        error.value = 'Failed to load assignments';
      }
    } catch (e) {
      error.value = 'An error occurred: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  // Call this when initializing the controller
  @override
  void onInit() {
    super.onInit();

    fetchAssignments();
  }

  // Call this when disposing the controller
  @override
  void onClose() {
    super.onClose();
  }
}
