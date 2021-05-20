import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:remind_me/providers/ClassesToday.dart';
import 'package:remind_me/providers/Subjects.dart';
import 'package:remind_me/shared/globals.dart';

class CalenderTimeLine extends StatefulWidget {
  final int day;
  final Function changeState;

  CalenderTimeLine({
    Key? key,
    required this.day,
    required this.changeState,
  }) : super(key: key);

  @override
  _CalenderTimeLineState createState() => _CalenderTimeLineState();
}

class _CalenderTimeLineState extends State<CalenderTimeLine> {
  @override
  Widget build(BuildContext context) {
    int _day = widget.day;
    final subjects = Provider.of<Subjects>(context).subjects;
    final classesTodayProvider = Provider.of<ClassesToday>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 60,
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          itemBuilder: (BuildContext context, int idx) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 60,
                  height: 85,
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 8,
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Global.days[_day] == Global.week[idx]['day']
                              ? Color(0xFF3F33C7)
                              : Colors.grey[200],
                      elevation: 3.0,
                    ),
                    onPressed: () => {
                      setState(
                        () {
                          classesTodayProvider.generateTodaysClasses(
                              day: idx, subjects: subjects);
                          _day = idx;
                          widget.changeState(idx);
                        },
                      )
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Global.week[idx]['day'][0],
                          style: TextStyle(
                            fontSize: 14,
                            color: Global.days[_day] == Global.week[idx]['day']
                                ? Colors.white70
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          Global.week[idx]['date'].toString(),
                          style: TextStyle(
                            fontSize: 17,
                            color: Global.days[_day] == Global.week[idx]['day']
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
