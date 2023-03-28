import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/components/calender_timeLine.dart';
import 'package:remind_me/components/day_class.dart';
import 'package:remind_me/providers/ClassesToday.dart';
import 'package:remind_me/providers/calendar_provider.dart';
import 'package:remind_me/providers/subjects_provider.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateTime curDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = MediaQuery.of(context).size.width;

    final subjects = context.watch<SubjectsProvider>().subjects;
    final calendarProvider = context.read<CalendarProvider>();
    final classesTodayProvider = context.watch<ClassesToday>();

    void changeState(int day) {
      Provider.of<ClassesToday>(context, listen: false).generateTodaysClasses(
        subjects: subjects,
        day: day,
      );

      setState(() {
        curDay = DateTime.utc(DateTime.now().year, DateTime.now().month,
            calendarProvider.week[day]['date']);
      });
    }

    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 30,
          ),
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: theme.shadowColor,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            calendarProvider.months[curDay.month],
                            style: TextStyle(
                              color: theme.cardColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            " ${curDay.year}",
                            style: TextStyle(
                              color: theme.shadowColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${curDay.day} ${calendarProvider.days[curDay.weekday - 1]}",
                        style: TextStyle(
                          color: theme.cardColor,
                          fontWeight: FontWeight.bold,
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
          top: 140,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.only(
              top: 15,
              right: 10,
              bottom: 10,
            ),
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
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
                      classesTodayProvider.classesToday.isEmpty
                          ? const Center(
                              child: Text(
                                "No Classes",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount:
                                    classesTodayProvider.classesToday.length,
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
                    ],
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
