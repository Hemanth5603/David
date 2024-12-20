import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import '../../api.dart';
import '../models/assignment_model.dart';

class StudentAssignmentController extends GetxController {
  final Rx<AssignmentModel?> assignments = Rx<AssignmentModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxBool isSubmitting = false.obs;

  Future<void> fetchAssignments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String branch = prefs.getString("branch") ?? 'CSE';
    try {
      isLoading.value = true;
      error.value = '';

      final response = await http.get(
        Uri.parse('${API.baseUrl}${API.getAssignments}$branch'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        assignments.value = AssignmentModel.fromJson(data);
        print(assignments.value);
      } else {
        error.value = 'Failed to load assignments';
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> submitAssignment({
    required String studentId,
    required String studentName,
    required String branch,
    required String subjectName,
    required String assignmentTitle,
    required String pdfPath,
    required String fileName,
  }) async {
    try {
      isLoading.value = true;
      isSubmitting.value = true;
      error.value = '';

      // Check if the PDF file exists
      if (!await File(pdfPath).exists()) {
        Get.snackbar('Error', 'The file does not exist at the specified path.',
            snackPosition: SnackPosition.TOP);
        return false;
      }

      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${API.baseUrl}/user/submit-assignment'),
      );
      print("caled ASPI---------------------------------");
      // Add text fields
      request.fields['student_id'] = studentId;
      request.fields['student_name'] = studentName;
      request.fields['branch'] = branch;
      request.fields['subject_name'] = subjectName;
      request.fields['assignment_title'] = assignmentTitle;

      // Add PDF file
      request.files.add(
        await http.MultipartFile.fromPath(
          'pdf_file',
          pdfPath,
          filename: fileName,
          contentType: MediaType('application', 'pdf'),
        ),
      );
      print("Request Sent--------------------------------");
      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      isLoading(false);

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Assignment submitted successfully',
          snackPosition: SnackPosition.TOP,
        );
        return true;
      } else {
        final errorMessage = json.decode(response.body)['message'] ??
            'Failed to submit assignment';
        print(errorMessage);
        error.value = errorMessage;
        Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.TOP);

        return false;
      }
    } catch (e) {
      error.value = e.toString();
      print(error.value);
      Get.snackbar(
        'Error',
        'Failed to submit assignment: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    } finally {
      isSubmitting.value = false;
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
