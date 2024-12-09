import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:prototype/api.dart';
import 'package:prototype/student/models/leaderboard_model.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/student/views/tabs/leaderboard.dart';

class LeaderboardController extends GetxController {
  Rx<StudentLeaderBoardModel?> studentLeaderboard =
      Rx<StudentLeaderBoardModel?>(null);
  var isLoading = false.obs;

  void getStudentLeaderBoard() async {
    try {
      isLoading.value = true;

      // Make the API call to your backend
      final response = await http.get(
        Uri.parse('${API.baseUrl}${API.getStudentLeaderboard}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        studentLeaderboard.value =
            StudentLeaderBoardModel.fromJson(responseData);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Fluttertoast.showToast(
          msg: "Failed to fetch leaderboard",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
        );
        return null;
      }
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) print('Error fetching leaderboard in: $e');
      Fluttertoast.showToast(
        msg: "An error occurred during login",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
      );
      return null;
    }
  }
}
