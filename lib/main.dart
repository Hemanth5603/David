import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
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
import 'package:prototype/student/views/tabs/leaderboard.dart';
import 'package:flutter/services.dart' show rootBundle;

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

class NotificationSoundPlayer {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  // Verify and convert audio file if necessary
  static Future<File?> _prepareAudioFile(String assetPath) async {
    try {
      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/siren.wav');

      // Check if file exists and can be read
      if (await tempFile.exists()) {
        return tempFile;
      }

      // If file doesn't exist, try to copy from assets
      try {
        // Load asset as bytes
        final byteData = await rootBundle.load(assetPath);

        // Write to temporary file
        await tempFile.writeAsBytes(byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

        return tempFile;
      } catch (e) {
        print('Error preparing audio file: $e');
        return null;
      }
    } catch (e) {
      print('Unexpected error in audio file preparation: $e');
      return null;
    }
  }

  // Play sound for alert notifications
  static Future<void> playAlertSound() async {
    try {
      // Ensure you have a compatible audio file (WAV is usually most reliable)
      final audioFile = await _prepareAudioFile('assets/sounds/siren.wav');

      if (audioFile == null) {
        print('No valid audio file found');
        return;
      }

      // Set audio source from file
      await _audioPlayer.setAudioSource(
        AudioSource.file(audioFile.path),
        initialPosition: Duration.zero,
      );

      // Set volume and play
      await _audioPlayer.setVolume(1.0);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing alert sound: $e');
    }
  }

  // Play sound for regular notifications
  static Future<void> playRegularSound() async {
    try {
      // Ensure you have a compatible audio file (WAV is usually most reliable)
      final audioFile = await _prepareAudioFile('assets/sounds/siren.wav');

      if (audioFile == null) {
        print('No valid audio file found');
        return;
      }

      // Set audio source from file
      await _audioPlayer.setAudioSource(
        AudioSource.file(audioFile.path),
        initialPosition: Duration.zero,
      );

      // Set volume and play
      await _audioPlayer.setVolume(0.4);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing regular notification sound: $e');
    }
  }
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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        // Check if it's an alert notification
        if (message.data['type'] == 'alert' ||
            message.data['topic'] == 'alert') {
          // Play alert sound
          await NotificationSoundPlayer.playAlertSound();

          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'alert_channel',
                'Alert Notifications',
                icon: android.smallIcon,
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
          );
        } else {
          // Play regular notification sound
          await NotificationSoundPlayer.playRegularSound();

          // Show regular notification
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel',
                'High Importance Notifications',
                icon: android.smallIcon,
                importance: Importance.defaultImportance,
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
        return FacultyHome();
      }

//StudentHome()
      return OnBoardingPage();
    });
  }
}
