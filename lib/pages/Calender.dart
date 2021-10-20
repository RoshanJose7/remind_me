import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/components/CalenderTimeLine.dart';
import 'package:remind_me/components/DayClass.dart';
import 'package:remind_me/providers/ClassesToday.dart';
import 'package:remind_me/providers/Subjects.dart';
import 'package:remind_me/shared/globals.dart';

class CalenderPage extends StatefulWidget {
  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateTime curDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final subjects = Provider.of<Subjects>(context).subjects;
    final classesTodayProvider = Provider.of<ClassesToday>(context);
    final _theme = Theme.of(context);

    void changeState(int day) {
      Provider.of<ClassesToday>(context, listen: false).generateTodaysClasses(
        subjects: subjects,
        day: day,
      );

      setState(() {
        curDay = DateTime.utc(DateTime.now().year, DateTime.now().month,
            Global.week[day]['date']);
      });
    }

    return SafeArea(
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 30,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _theme.backgroundColor,
                  Color(0xFFF0F0F0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.6, 0.3],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: _theme.shadowColor,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            Global.months[curDay.month],
                            style: TextStyle(
                              color: _theme.cardColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            " ${curDay.year}",
                            style: TextStyle(
                              color: _theme.shadowColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${curDay.day} ${Global.days[curDay.weekday - 1]}",
                        style: TextStyle(
                          color: _theme.cardColor,
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
            bottom: 0,
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
                          day: curDay.weekday - 1,
                          changeState: changeState,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        classesTodayProvider.classesToday.length == 0
                            ? Center(
                                child: Text(
                                  "No Classes",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Container(
                                child: Expanded(
                                  child: ListView.builder(
                                    itemCount: classesTodayProvider
                                        .classesToday.length,
                                    itemBuilder: (_, int idx) {
                                      return DayClass(
                                        time:
                                            "${classesTodayProvider.classesToday[idx].timeSlots[curDay.weekday - 1]!.split(":")[0]}:${classesTodayProvider.classesToday[idx].timeSlots[curDay.weekday - 1]!.split(":")[1]}",
                                        duration: classesTodayProvider
                                            .classesToday[idx].duration,
                                        subjectName: classesTodayProvider
                                            .classesToday[idx].subjectName,
                                        professorName: classesTodayProvider
                                            .classesToday[idx].professorName,
                                        roomName: classesTodayProvider
                                            .classesToday[idx].roomName,
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
