import 'package:remind_me/models/Subject.dart';

class Global {
  static String userName = "Jose";
  static String picPath = "assets/img/Jose.jpg";

  static List<Subject> allSubjects = [
    Subject(
      duration: "1 hr",
      subjectName: "Data Structures and Algorithms",
      professorImage: "assets/img/Gabriel.jpg",
      professorName: "Gabriel Sutton",
      roomName: "Computer Science Engineering:Room C1, 2nd floor",
      timeSlots: [
        null,
        "AM 08:00",
        null,
        null,
        null,
        "PM 12:00",
        null,
      ],
    ),
    Subject(
      duration: "1 hr 30 min",
      subjectName: "Internet of Things",
      professorImage: "assets/img/Stella.jpg",
      professorName: "Stella Varghese",
      roomName: "Electronics and Communication:Room A3, 2nd floor",
      timeSlots: [
        null,
        "AM 09:00",
        "AM 10:00",
        null,
        null,
        null,
        null,
      ],
    ),
    Subject(
      duration: "1 hr 45 min",
      subjectName: "Engineering Mathematics",
      professorImage: "assets/img/Alexander.jpg",
      professorName: "Alexander Andrio",
      roomName: "Engineering Mathematics:Room B4, 2st floor",
      timeSlots: [
        null,
        "PM 03:00",
        null,
        null,
        "AM 09:00",
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

  static List tasks = [
    {
      'days': 3,
      'subjectName': "Engineering Mathematics Assignment - I",
    },
    {
      'days': 10,
      'subjectName': "Data Structures and Algorithms Record",
    },
    {
      'days': 7,
      'subjectName': "Internet of Things Internals",
    },
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
