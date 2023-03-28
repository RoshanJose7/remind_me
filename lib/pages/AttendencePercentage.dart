import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/components/PercentageIndicator.dart';
import 'package:remind_me/providers/calendar_provider.dart';
import 'package:remind_me/providers/subjects_provider.dart';

class AttendancePercentagePage extends StatefulWidget {
  const AttendancePercentagePage({Key? key}) : super(key: key);

  @override
  _AttendancePercentagePageState createState() =>
      _AttendancePercentagePageState();
}

class _AttendancePercentagePageState extends State<AttendancePercentagePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final calendarProvider = context.read<CalendarProvider>();
    final subjectsAttendance =
        context.watch<SubjectsProvider>().subjectsAttendance;

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.backgroundColor,
                const Color(0xFFF0F0F0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.6, 0.3],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      calendarProvider.days[DateTime.now().weekday - 1],
                      style: TextStyle(
                        color: theme.cardColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      " ${DateTime.now().day} ${calendarProvider.months[DateTime.now().month - 1]}",
                      style: TextStyle(
                        color: theme.shadowColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "Attendance %",
                          style: TextStyle(
                            color: theme.cardColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 150,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            height: height - 240,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Expanded(
                  child: subjectsAttendance.isNotEmpty
                      ? ListView.builder(
                          itemCount: subjectsAttendance.length,
                          itemBuilder: (context, idx) => PercentageIndicator(
                            key: Key(idx.toString()),
                            subId: subjectsAttendance[idx].id,
                            subjectName: subjectsAttendance[idx].subjectName,
                            completedPercent:
                                ((subjectsAttendance[idx].classesAttended /
                                            subjectsAttendance[idx]
                                                .totalClassesCompleted) *
                                        100)
                                    .toDouble(),
                            totalClasses: subjectsAttendance[idx]
                                .totalClassesCompleted
                                .toInt(),
                            attendedClasses:
                                subjectsAttendance[idx].classesAttended.toInt(),
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Go to the Subjects page and add a new subject",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
