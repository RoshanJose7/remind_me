import 'package:flutter/cupertino.dart';

DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
int findDateOfTheWeek(int num) {
  final date = DateTime.now();
  return int.parse(
    getDate(date.subtract(Duration(days: date.weekday - num)))
        .toString()
        .split(" ")[0]
        .split("-")[2],
  );
}

class CalendarProvider with ChangeNotifier {
  get days => [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      ];
  get months => [
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

  late int _start;
  late int _last;

  final List _week = [];

  int get start => _start;
  int get last => _last;
  List get week => _week;

  CalendarProvider() {
    _start = findDateOfTheWeek(1);
    _last = findDateOfTheWeek(7);
    generateDays();
  }

  void generateDays() {
    for (int idx = 0; idx < 7; idx++) {
      _week.add({'day': days[idx], 'date': findDateOfTheWeek(idx + 1)});
    }

    notifyListeners();
  }
}
