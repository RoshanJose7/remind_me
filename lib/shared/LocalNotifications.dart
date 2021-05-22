import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  late FlutterLocalNotificationsPlugin fltrNotification;

  void init() {
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
      android: androidInitilize,
      iOS: iOSinitilize,
    );
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(
      initilizationsSettings,
      onSelectNotification: notificationSelected,
    );
  }

  tz.TZDateTime nextInstanceOfDayTime({required DateTime date}) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      date.hour,
      date.minute,
    );

    return scheduledDate;
  }

  Future notificationSelected(String? payload) async {
    print("Payload : $payload");
  }

  Future<void> scheduleNotification({required DateTime date}) async {
    var scheduledNotificationDateTime = DateTime.now().add(
      Duration(
        minutes: (DateTime.now().difference(date).inMinutes),
      ),
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: 'app_icon',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // ignore: deprecated_member_use
    await fltrNotification.schedule(
      0,
      'scheduled title',
      'scheduled body',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> scheduleAtDayAndTimeNotification(
      {required DateTime date}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: 'app_icon',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await fltrNotification.zonedSchedule(
      0,
      'weekly scheduled notification title',
      'weekly scheduled notification body',
      nextInstanceOfDayTime(date: date),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      "Channel ID",
      "Desi programmer",
      "This is my channel",
      importance: Importance.high,
    );
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails = new NotificationDetails(
      android: androidDetails,
      iOS: iSODetails,
    );

    await fltrNotification.show(
      0,
      "Task",
      "You created a Task",
      generalNotificationDetails,
      payload: "Task",
    );
  }
}
