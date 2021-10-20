import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/components/TaskDetailCard.dart';
import 'package:remind_me/pages/AddTask.dart';
import 'package:remind_me/providers/Tasks.dart';
import 'package:remind_me/shared/globals.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final _theme = Theme.of(context);
    final tasks = Provider.of<Tasks>(context).tasks;

    return SafeArea(
      child: Stack(
        fit: StackFit.loose,
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
                    "Your Tasks",
                    style: TextStyle(
                      color: _theme.cardColor,
                      fontSize: 27,
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
            top: 110,
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
                  Container(
                    width: double.infinity,
                    height: height - 220,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              backgroundColor: _theme.primaryColor,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTask(),
                ),
              ),
              child: Icon(Icons.add_to_photos_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
