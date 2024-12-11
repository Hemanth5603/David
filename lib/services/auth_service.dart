import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxController {
  static AuthService get to => Get.find();

  final RxBool isLoggedIn = false.obs;
  final RxString userType = ''.obs; // 'student' or 'faculty'

  final String _isLoggedInKey = 'isLoggedIn';
  final String _userTypeKey = 'userType';

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool(_isLoggedInKey) ?? false;
    userType.value = prefs.getString(_userTypeKey) ?? '';
  }

  Future<void> loginAsStudent() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_userTypeKey, 'student');
    isLoggedIn.value = true;
    userType.value = 'student';
  }

  Future<void> loginAsFaculty() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_userTypeKey, 'faculty');
    isLoggedIn.value = true;
    userType.value = 'faculty';
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    //await prefs.clear();
    isLoggedIn.value = false;
    userType.value = '';
    Get.offAllNamed('/onboarding');
  }
}
