import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/components/SubjectCard.dart';
import 'package:remind_me/components/add_subject.dart';
import 'package:remind_me/providers/calendar_provider.dart';
import 'package:remind_me/providers/subjects_provider.dart';

class AllSubjectsPage extends StatefulWidget {
  const AllSubjectsPage({super.key});

  @override
  _AllSubjectsPageState createState() => _AllSubjectsPageState();
}

class _AllSubjectsPageState extends State<AllSubjectsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Tween<Offset> _tween =
      Tween(begin: const Offset(0, 1), end: const Offset(0, 0));

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final subjects = context.watch<SubjectsProvider>().subjects;
    final calendarProvider = context.read<CalendarProvider>();

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
                Container(
                  child: Row(
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
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "Subjects",
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
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "All Subjects",
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "(${subjects.length})",
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: height - 312,
                  width: width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: subjects.isEmpty
                      ? const Center(
                          child: Text(
                            "Click on the + button to add Subjects!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: subjects.length,
                          itemBuilder: (ctx, idx) {
                            return SubjectCard(
                              id: subjects[idx].id,
                              duration: subjects[idx].duration,
                              professorName: subjects[idx].professorName,
                              roomName: subjects[idx].roomName,
                              subName: subjects[idx].subjectName,
                              timeSlots: subjects[idx].timeSlots,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: theme.primaryColor,
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else if (_controller.isCompleted) {
                _controller.reverse();
              }
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox.expand(
          child: SlideTransition(
            position: _tween.animate(_controller),
            child: DraggableScrollableSheet(
              maxChildSize: 0.82,
              minChildSize: 0.4,
              expand: true,
              builder: (_, controller) {
                return SingleChildScrollView(
                  controller: controller,
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: theme.backgroundColor, width: 5),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 35, horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _controller.reverse(),
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            Text(
                              "Add Subject",
                              style: TextStyle(
                                fontFamily: "Righteous",
                                fontSize: 24,
                                color: theme.cardColor,
                              ),
                            ),
                          ],
                        ),
                        AddSubject(controller: _controller),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
