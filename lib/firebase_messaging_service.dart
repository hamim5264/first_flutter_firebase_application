import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    _firebaseMessaging.requestPermission(
      sound: true,
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );
  }

  Future<void> initialize() async {
    await requestPermission();

    //Normal/Alive/On-Pause
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    //Open/Resume
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    //Dead/On-Terminated
    FirebaseMessaging.onBackgroundMessage(handleBackgroundNotification);
  }

  Future<void> getFCMToken() async {
    final token = await _firebaseMessaging.getToken();
    print(token);
  }

  Future<void> onRefresh(Function(String) onTokenRefresh) async {
    _firebaseMessaging.onTokenRefresh.listen((token) {
      onTokenRefresh(token);
    });
  }

  Future<void> subscribeToTopic(String topic) async {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeToTopic(String topic) async {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

Future<void> handleBackgroundNotification(RemoteMessage message) async {}
