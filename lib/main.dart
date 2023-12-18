import 'package:firebase_core/firebase_core.dart';
import 'package:first_flutter_firebase_application/firebase_messaging_service.dart';
import 'dart:io';
import 'package:first_flutter_firebase_application/firebase_student_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: "AIzaSyCc40-RDhxoQDdbd6embeiOe3u0zOR6FUg",
          appId: "1:58610389375:android:39c63e9f292c2e3c618a4a",
          messagingSenderId: "58610389375",
          projectId: "first-flutter-firebase-p-9a05f",
        ))
      : await Firebase.initializeApp();
  await FirebaseMessagingService().initialize();
  await FirebaseMessagingService().getFCMToken();
  await FirebaseMessagingService().subscribeToTopic("the-new-boston");
  await FirebaseMessagingService().onRefresh((token) {
    //Todo - send to api
  });
  runApp(const FirebaseStudentApp());
}
