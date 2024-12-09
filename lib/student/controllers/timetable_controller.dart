import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:prototype/api.dart';
import 'package:prototype/student/models/time_table_model.dart';
import 'package:prototype/student/views/tabs/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TimeTableController extends GetxController {
  Rx<TimeTableModel?> timetable = Rx<TimeTableModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchLeaderboard();
  }

  void fetchLeaderboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String branch = prefs.getString("branch") ?? 'CSE';

    var isLoading = false.obs;
    try {
      isLoading.value = true;
      final url = Uri.parse('${API.baseUrl}${API.getTimetable}$branch');
      print(url);

      final response = await http.get(
        Uri.parse('${API.baseUrl}${API.getTimetable}$branch'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        timetable.value = TimeTableModel.fromJson(data);
      } else {
        print('Error fetching timetable');
      }
    } catch (e) {
      print("Error fetching timetable: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
