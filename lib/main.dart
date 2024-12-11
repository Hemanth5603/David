import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:prototype/auth/on_boarding.dart';
import 'package:vibration/vibration.dart';
import 'package:prototype/faculty/views/auth/login.dart';
import 'package:prototype/faculty/views/faculty_home.dart';
import 'package:prototype/faculty/views/find_face_student_details.dart';
import 'package:prototype/faculty/views/tabs/faculty_home_page.dart';
import 'package:prototype/services/auth_service.dart';
import 'package:prototype/student/controllers/notification_controller.dart';
import 'package:prototype/student/models/student_model.dart';
import 'package:prototype/student/views/home.dart';
import 'package:prototype/student/views/tabs/home_page.dart';
import 'package:prototype/firebase_options.dart';

// Initialize FlutterLocalNotificationsPlugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// This is needed to handle background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // System UI setup
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(0, 35, 37, 49),
  ));

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize AuthService
  final authService = Get.put(AuthService());
  await authService.init();

  // Firebase Messaging Setup
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.subscribeToTopic('all');
  await FirebaseMessaging.instance
      .subscribeToTopic('alert'); // Subscribe to alert topic

  // Local Notifications Setup
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (details) {
      print('Notification tapped: ${details.payload}');
    },
  );

  // Create regular notification channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
  );

  // Create alert notification channel with custom sound
  const AndroidNotificationChannel alertChannel = AndroidNotificationChannel(
    'alert_channel',
    'Alert Notifications',
    importance: Importance.max,
    playSound: true,
    sound: RawResourceAndroidNotificationSound(
        'audio'), // Make sure to add this sound file
    enableVibration: true,
    enableLights: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(alertChannel);
  print('Alert channel created with sound: alert_sound');

  // Get FCM token
  String? token = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $token');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _setupForegroundNotificationHandling();
  }

  // Add this import

  void _setupForegroundNotificationHandling() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        // Check if it's an alert notification
        if (message.data['type'] == 'alert' ||
            message.data['topic'] == 'alert') {
          // Trigger continuous vibration
          Vibration.vibrate(
              duration: 1000, amplitude: 128); // Vibrate for 1 second

          // Show the notification
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel',
                'High Importance Notifications',
                icon: android.smallIcon,
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
          );
        } else {
          // Handle regular notifications
          print("Alerted --------------/-/-/-/-///////////////////");
          Vibration.vibrate(duration: 5000, amplitude: 128);
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel',
                'High Importance Notifications',
                icon: android.smallIcon,
              ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const InitialRouter()),
        GetPage(name: '/onboarding', page: () => OnBoardingPage()),
        GetPage(name: '/student/home', page: () => const StudentHome()),
        GetPage(name: '/faculty/home', page: () => const FacultyHomePage()),
      ],
    );
  }
}

class InitialRouter extends StatelessWidget {
  const InitialRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!AuthService.to.isLoggedIn.value) {
        return OnBoardingPage();
      }

      if (AuthService.to.userType.value == 'student') {
        return const StudentHome();
      } else if (AuthService.to.userType.value == 'faculty') {
        return OnBoardingPage();
      }

//StudentHome()
      return OnBoardingPage();
    });
  }
}
