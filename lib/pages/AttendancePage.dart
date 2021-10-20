import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/components/PercentageIndicator.dart';
import 'package:remind_me/providers/Subjects.dart';
import 'package:remind_me/shared/globals.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final subjects = Provider.of<Subjects>(context).subjects;
    final _theme = Theme.of(context);

    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 10,
                    top: 40,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _theme.backgroundColor,
                        const Color(0xFFF0F0F0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.6, 0.3],
                    ),
                  ),
                  child: Text(
                    "Attendance Percentage",
                    style: TextStyle(
                      color: _theme.cardColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 30,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          Global.days[DateTime.now().weekday - 1],
                          style: TextStyle(
                            color: _theme.cardColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          " ${DateTime.now().day} ${Global.months[DateTime.now().month - 1]}",
                          style: TextStyle(
                            color: _theme.shadowColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
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
                    child: subjects.length > 0
                        ? ListView.builder(
                            itemCount: subjects.length,
                            itemBuilder: (context, idx) => PercentageIndicator(
                              key: Key(idx.toString()),
                              subId: subjects[idx].id,
                              subjectName: subjects[idx].subjectName,
                              completedPercent:
                                  ((subjects[idx].classesAttended /
                                          subjects[idx].totalClassesCompleted) *
                                      100),
                              totalClasses: subjects[idx].totalClassesCompleted,
                              attendedClasses: subjects[idx].classesAttended,
                            ),
                          )
                        : Center(
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
      ),
    );
  }
}
