import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/api.dart';
import 'package:prototype/faculty/models/resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResourceController extends GetxController {
  var isLoading = false.obs;
  Rx<ResourceAllocation?> resources = Rx<ResourceAllocation?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchResourceRequests();
  }

  Future<void> resourceRequest(
      String type, String timeslot, String subtype) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("fname") ?? 'Harshavardhan';
    String branch = prefs.getString("fbranch") ?? 'CSE';
    try {
      final response = await http.post(
        Uri.parse('${API.baseUrl}/admin/request-resource'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'faculty_name': name,
          'resource_type': type,
          'sub_type': subtype,
          'time_slot': timeslot,
          'branch': branch,
          'status': 1,
        }),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Requested successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Could Not Request Resource",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      print('Error sending Request : $e');
    }
  }

  Future<void> fetchResourceRequests() async {
    try {
      isLoading.value = true;
      print("Called");
      // Replace with your actual API endpoint
      final response = await http.get(
        Uri.parse('${API.baseUrl}${API.fetchResourceRequests}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        resources.value = ResourceAllocation.fromJson(data);
        print(resources.value);
      } else {
        throw Exception('Failed to fetch requests');
      }
    } catch (e) {
      print('Failed to fetch requests: $e');
      // You can add proper error handling here
    } finally {
      isLoading.value = false;
    }
  }
}
