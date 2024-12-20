import 'package:prototype/faculty/views/auth/global_search.dart';

class API {
  static const mlurl = "https://ebb6-103-177-203-130.ngrok-free.app";
  static const attendance = "/upload-video/";
  static const mlregisterface = "/register-face/";
  static const mlfindface = "/upload-image/";
  static const baseUrl = "https://david-backend-production.up.railway.app";
  static const login = "/user/login";
  static const getUserByRoll = "/user/fetch-student/";
  static const facultyLogin = "/faculty/login";
  static const getAssignments = "/user/fetch-assignments/";
  static const createAssignment = "/admin/create-assignment";
  static const getSubmittedAssignments = "/user/fetch-submissions/CSM";
  static const getFacultyLeaderboard = "/faculty/leaderboard";
  static const getTimetable = "/timetable/";
  static const getStudentLeaderboard = "/students/rankings";
  static const takeFacultyAttendane = "/faculty/attendance";
  static const sendLeaveRequest = "/student/leave-request";
  static const generateNotes = "/generate-notes/";
  static const fetchscripts = "/student/fetch-scripts";
  static const fetchResourceRequests = "/admin/get-all-requests";
  static const globalsearch = "/search-global/";
}
