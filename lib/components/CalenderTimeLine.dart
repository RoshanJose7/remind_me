import 'package:flutter/material.dart';

import 'package:remind_me/shared/globals.dart';
import 'package:remind_me/pages/Calender.dart';

// ignore: must_be_immutable
class CalenderTimeLine extends StatefulWidget {
  int day;
  Function generateTodaysClasses;
  Function changeState;
  CalenderTimeLine({
    Key? key,
    required this.day,
    required this.generateTodaysClasses,
    required this.changeState,
  }) : super(key: key);

  @override
  _CalenderTimeLineState createState() => _CalenderTimeLineState();
}

class _CalenderTimeLineState extends State<CalenderTimeLine> {
  @override
  Widget build(BuildContext context) {
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
                  width: 55,
                  height: 60,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 8,
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Global.days[widget.day] == Global.week[idx]['day']
                            ? Color(0xFF3F33C7)
                            : Colors.grey.withOpacity(0.1),
                      ),
                    ),
                    onPressed: () => {
                      setState(
                        () {
                          CalenderPage.generateTodaysClasses(day: idx);
                          widget.day = idx;
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
                            color: Global.days[widget.day] ==
                                    Global.week[idx]['day']
                                ? Colors.white70
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          Global.week[idx]['date'].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Global.days[widget.day] ==
                                    Global.week[idx]['day']
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600,
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
