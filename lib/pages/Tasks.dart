import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/components/AddTask.dart';
import 'package:remind_me/components/TaskDetailCard.dart';
import 'package:remind_me/providers/Tasks.dart';
import 'package:remind_me/shared/globals.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final _theme = Theme.of(context);
    final tasks = Provider.of<Tasks>(context).tasks;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "Tasks",
                          style: TextStyle(
                            color: _theme.cardColor,
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
            padding: EdgeInsets.only(
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
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "All Tasks",
                              style: TextStyle(
                                color: _theme.primaryColor,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "(${tasks.length})",
                              style: TextStyle(
                                color: _theme.primaryColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          flex: 4,
                          child: tasks.length == 0
                              ? Center(
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
            backgroundColor: _theme.primaryColor,
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else if (_controller.isCompleted) {
                _controller.reverse();
              }
            },
            child: Icon(Icons.add_to_photos_rounded, color: Colors.white),
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
                          Border.all(color: _theme.backgroundColor, width: 5),
                      borderRadius: BorderRadius.only(
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
                              icon: Icon(
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
                                color: _theme.cardColor,
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
