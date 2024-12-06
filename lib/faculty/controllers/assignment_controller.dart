import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prototype/api.dart';
import 'package:prototype/constants.dart';
import 'package:prototype/faculty/models/assignment_submission_model.dart';

class AssignmentController extends GetxController {
  var isLoading = false.obs;
  final Rx<AssignmentSubmissionModel?> submissions =
      Rx<AssignmentSubmissionModel?>(null);

  Future<void> createAssignment({
    required String title,
    required String description,
    required int facultyId,
    required String facultyName,
    required String subject,
    required String branch,
    required DateTime dueDate,
    String status = 'active',
  }) async {
    try {
      isLoading(true);

      final Map<String, dynamic> assignmentData = {
        'title': title,
        'description': description,
        'faculty_id': facultyId,
        'faculty_name': facultyName,
        'subject': subject,
        'branch': branch,
        'due_date':
            DateTime(dueDate.year, dueDate.month, dueDate.day, 23, 59, 59)
                .toUtc()
                .toIso8601String(),
        'status': status,
      };

      print("Request body: ${jsonEncode(assignmentData)}");

      final response = await http.post(
        Uri.parse("${API.baseUrl}${API.createAssignment}"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(assignmentData),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Assignment created successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: "Failed to create assignment",
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

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getAssignmentSubmissions() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${API.baseUrl}${API.getSubmittedAssignments}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        submissions.value = AssignmentSubmissionModel.fromJson(data);
      } else {
        throw Exception('Failed to load submissions');
      }
    } catch (e) {
      print('Error fetching submissions: $e');
      throw e;
    } finally {
      isLoading.value = false;
    }
  }
}
