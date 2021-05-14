import 'package:flutter/material.dart';

import 'package:remind_me/components/CalenderTimeLine.dart';
import 'package:remind_me/components/DayClass.dart';
import 'package:remind_me/models/Subject.dart';
import 'package:remind_me/shared/globals.dart';

class CalenderPage extends StatefulWidget {
  static List<Subject> classesToday = [];

  static void generateTodaysClasses({int? day}) {
    int curDay = day == null ? DateTime.now().weekday - 1 : day;
    classesToday = [];

    Global.allSubjects.forEach(
        (sub) => {if (sub.timeSlots[curDay] != null) classesToday.add(sub)});

    classesToday
        .sort((a, b) => a.timeSlots[curDay].compareTo(b.timeSlots[curDay]));
  }

  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  int curDay = DateTime.now().weekday - 1;

  void changeState(int day) {
    setState(() {
      curDay = day;
    });
  }

  @override
  void initState() {
    super.initState();
    CalenderPage.generateTodaysClasses();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 40,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFECEDED),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "Oct",
                            style: TextStyle(
                              color: Color(0xFF272F66),
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            " 2021",
                            style: TextStyle(
                              color: Color(0xFF272F66),
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Today",
                        style: TextStyle(
                          color: Color(0xFF4235C8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              padding: EdgeInsets.only(
                top: 15,
                right: 10,
                bottom: 10,
              ),
              height: height - 160,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CalenderTimeLine(
                          day: curDay,
                          generateTodaysClasses:
                              CalenderPage.generateTodaysClasses,
                          changeState: changeState,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Expanded(
                            child: ListView.builder(
                              itemCount: CalenderPage.classesToday.length,
                              itemBuilder: (BuildContext context, int idx) {
                                return DayClass(
                                  time: CalenderPage
                                      .classesToday[idx].timeSlots[curDay],
                                  duration:
                                      CalenderPage.classesToday[idx].duration,
                                  subjectName: CalenderPage
                                      .classesToday[idx].subjectName,
                                  professorImage: CalenderPage
                                      .classesToday[idx].professorImage,
                                  professorName: CalenderPage
                                      .classesToday[idx].professorName,
                                  roomName:
                                      CalenderPage.classesToday[idx].roomName,
                                );
                              },
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
        ],
      ),
    );
  }
}
