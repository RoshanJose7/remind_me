import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/providers/ClassesToday.dart';
import 'package:remind_me/providers/calendar_provider.dart';
import 'package:remind_me/providers/subjects_provider.dart';

class CalenderTimeLine extends StatefulWidget {
  final int day;
  final Function changeState;

  const CalenderTimeLine({
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
    int day = widget.day;
    final theme = Theme.of(context);
    final subjects = context.watch<SubjectsProvider>().subjects;
    final calendarProvider = context.read<CalendarProvider>();
    final classesTodayProvider = context.watch<ClassesToday>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 60,
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: calendarProvider.week.length,
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
                      backgroundColor: calendarProvider.days[day] ==
                              calendarProvider.week[idx]['day']
                          ? theme.primaryColor
                          : Colors.grey[200],
                      elevation: 3.0,
                    ),
                    onPressed: () => {
                      setState(
                        () {
                          classesTodayProvider.generateTodaysClasses(
                              day: idx, subjects: subjects);
                          day = idx;
                          widget.changeState(idx);
                        },
                      )
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          calendarProvider.week[idx]['day'][0],
                          style: TextStyle(
                            fontSize: 14,
                            color: calendarProvider.days[day] ==
                                    calendarProvider.week[idx]['day']
                                ? Colors.white70
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          calendarProvider.week[idx]['date'].toString(),
                          style: TextStyle(
                            fontSize: 17,
                            color: calendarProvider.days[day] ==
                                    calendarProvider.week[idx]['day']
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
