import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ///Custom Notification Id
  static final _id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  ///[NotificationDetails] for andriod and iphone.
  static const NotificationDetails _notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      "high_importance_channel",
      "high_importance_channel_noti",
      importance: Importance.high,
      priority: Priority.high,
    ),
  );

  ///This is initialization function and is called in main.dart file.
  static Future<void> initialize() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  ///this method is responsible request Notifications permissions
  static Future<void> requestPermission() async {
    final result = await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    print(result);
  }

  static Future<void> showNotifications({
    required String title,
    required String body,
  }) async {
    return await _notificationsPlugin.show(
        _id, title, body, _notificationDetails);
  }
}
