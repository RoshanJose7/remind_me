import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

class LocalNotifications {
  late FlutterLocalNotificationsPlugin fltrNotification;
  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();
  BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();

  var initilizationsSettings;
  final uuid = Uuid();

  void init() {
    fltrNotification = new FlutterLocalNotificationsPlugin();
    initializePlatform();
  }

  Future<void> initializePlatform() async {
    var androidInitilize = new AndroidInitializationSettings('app_icon');
    var iOSinitilize = new IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification notification = ReceiveNotification(
            body: body!,
            id: id,
            payload: payload!,
            title: title!,
          );
          didReceiveLocalNotificationSubject.add(notification);
        });
    initilizationsSettings = new InitializationSettings(
      android: androidInitilize,
      iOS: iOSinitilize,
    );

    await fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        selectNotificationSubject.add(payload);
      }
    });
  }

  void configureSelectNotificationSubject(Future<void> Function() onClick) {
    selectNotificationSubject.stream.listen((String? payload) async {
      await onClick();
    });
  }

  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
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

  Future<void> scheduleNotification({
    required DateTime date,
    required String channelId,
    required String channelName,
    required String channelDesc,
    required String notificationTitle,
    required String notificationBody,
    required String payload,
  }) async {
    var scheduledNotificationDateTime = DateTime.now().add(
      Duration(
        minutes: (DateTime.now().difference(date).inMinutes),
      ),
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // ignore: deprecated_member_use
    await fltrNotification.schedule(
      0,
      notificationTitle,
      notificationBody,
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      payload: payload,
    );
  }

  Future<void> scheduleAtDayAndTimeNotification({
    required DateTime date,
    required String channelId,
    required String channelName,
    required String channelDesc,
    required String notificationTitle,
    required String notificationBody,
    required String payload,
  }) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await fltrNotification.zonedSchedule(
      1,
      notificationTitle,
      notificationBody,
      nextInstanceOfDayTime(date: date.subtract(Duration(minutes: 5))),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: payload,
    );
  }

  Future<void> repeatNotificationDaily({
    required DateTime date,
    required String channelId,
    required String channelName,
    required String channelDesc,
    required String notificationTitle,
    required String notificationBody,
    required String payload,
  }) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await fltrNotification.periodicallyShow(
      2,
      notificationTitle,
      notificationBody,
      RepeatInterval.daily,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      payload: payload,
    );
  }

  Future<void> showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      "Channel ID",
      "Desi programmer",
      "This is my channel",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails = new NotificationDetails(
      android: androidDetails,
      iOS: iSODetails,
    );

    await fltrNotification.show(
      3,
      "Task",
      "You created a Task",
      generalNotificationDetails,
      payload: "task",
    );
  }
}

class ReceiveNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceiveNotification({
    required this.body,
    required this.id,
    required this.payload,
    required this.title,
  });
}
