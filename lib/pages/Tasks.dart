import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/components/TaskDetailCard.dart';
import 'package:remind_me/components/add_task.dart';
import 'package:remind_me/providers/Tasks.dart';
import 'package:remind_me/providers/calendar_provider.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Tween<Offset> _tween =
      Tween(begin: const Offset(0, 1), end: const Offset(0, 0));

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = MediaQuery.of(context).size.width;

    final tasks = Provider.of<Tasks>(context).tasks;
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
                          "Tasks",
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
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "All Tasks",
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "(${tasks.length})",
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          flex: 4,
                          child: tasks.length == 0
                              ? const Center(
                                  child: Text(
                                    "Click on the + button to add your Tasks!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: tasks.length,
                                  itemBuilder: (BuildContext context, int idx) {
                                    return TaskDetailCard(
                                      id: tasks[idx].id,
                                      deadLine: tasks[idx].deadLine,
                                      description: tasks[idx].description,
                                      isCompleted: tasks[idx].isCompleted,
                                      subject: tasks[idx].subject,
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            backgroundColor: theme.primaryColor,
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else if (_controller.isCompleted) {
                _controller.reverse();
              }
            },
            child: const Icon(Icons.add_to_photos_rounded, color: Colors.white),
          ),
        ),
        SizedBox.expand(
          child: SlideTransition(
            position: _tween.animate(_controller),
            child: DraggableScrollableSheet(
              maxChildSize: 0.5,
              initialChildSize: 0.3,
              expand: false,
              snap: true,
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              "Add Task",
                              style: TextStyle(
                                fontFamily: "Righteous",
                                fontSize: 24,
                                color: theme.cardColor,
                              ),
                            ),
                          ],
                        ),
                        AddTask(),
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
