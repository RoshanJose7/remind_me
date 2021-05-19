class Global {
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
