import 'package:flutter/material.dart';
import 'package:remind_me/models/Subject.dart';
import 'package:remind_me/models/Task.dart';

class Global {
  static String userName = "Jose";
  static String picPath = "assets/img/Jose.jpg";

  static List<Subject> allSubjects = [
    Subject(
      duration: "1 hr",
      subjectName: "Data Structures and Algorithms",
      professorName: "Gabriel Sutton",
      roomName: "Computer Science Engineering:Room C1, 2nd floor",
      timeSlots: [
        null,
        TimeOfDay(hour: 8, minute: 0),
        null,
        null,
        null,
        TimeOfDay(hour: 12, minute: 0),
        null,
      ],
    ),
    Subject(
      duration: "1 hr 30 min",
      subjectName: "Internet of Things",
      professorName: "Stella Varghese",
      roomName: "Electronics and Communication:Room A3, 2nd floor",
      timeSlots: [
        null,
        TimeOfDay(hour: 09, minute: 0),
        TimeOfDay(hour: 10, minute: 0),
        null,
        null,
        TimeOfDay(hour: 15, minute: 0),
        null,
      ],
    ),
    Subject(
      duration: "1 hr 45 min",
      subjectName: "Engineering Mathematics",
      professorName: "Alexander Andrio",
      roomName: "Engineering Mathematics:Room B4, 2st floor",
      timeSlots: [
        null,
        TimeOfDay(hour: 08, minute: 0),
        null,
        null,
        TimeOfDay(hour: 10, minute: 10),
        null,
        null,
      ],
    ),
  ];
  static final List week = [];

  static const List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  static const List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sept",
    "Oct",
    "Nov",
    "Dec",
  ];

  static List<Task> tasks = [
    Task(
      isCompleted: false,
      subject: "Engineering Mathematics",
      description: "Assignment I - Second Order Differential Equations",
      deadLine: DateTime(2021, 5, 18, 10, 30),
    ),
    Task(
      isCompleted: true,
      subject: "Data Structures and Algorithms",
      description: "DS and Algo Lab Record",
      deadLine: DateTime(2021, 5, 27, 10, 30),
    ),
    Task(
      isCompleted: true,
      subject: "Internet of Things",
      description: "IOT Internals I",
      deadLine: DateTime(2021, 5, 28, 10, 30),
    ),
  ];

  static int start = int.parse(
    findFirstDateOfTheWeek(DateTime.now())
        .toString()
        .split(" ")[0]
        .split("-")[2],
  );

  static int last = int.parse(
    findLastDateOfTheWeek(DateTime.now())
        .toString()
        .split(" ")[0]
        .split("-")[2],
  );

  static void generateDays() {
    int idx = 0;

    while (start <= last && idx < 7)
      week.add({'day': days[idx++], 'date': start++});
  }

  static DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  static DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }
}
