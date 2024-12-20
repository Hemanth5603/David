import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants extends GetxController {
  static String baseUrl = "https://david-backend-production.up.railway.app/";

  static const Color customOrange = Color.fromARGB(197, 255, 155, 32);

  static List<BottomNavigationBarItem> tabs = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home_rounded),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.notification_add_outlined),
        activeIcon: Icon(Icons.notification_add),
        label: 'Reminders'),
    BottomNavigationBarItem(
        icon: Icon(Icons.leaderboard_rounded),
        activeIcon: Icon(Icons.leaderboard_rounded),
        label: 'Leaderboard'),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_outlined),
        activeIcon: Icon(Icons.person),
        label: 'Profile')
  ];
}
