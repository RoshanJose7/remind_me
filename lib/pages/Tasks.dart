import 'package:flutter/material.dart';

import 'package:remind_me/components/TaskDetailCard.dart';
import 'package:remind_me/models/Task.dart';
import 'package:remind_me/pages/AddTask.dart';
import 'package:remind_me/shared/globals.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  void addToAll({required Task task}) {
    setState(() {
      Global.tasks.add(task);
    });
  }

  void updateTask({required int id}) {
    setState(() {
      Global.tasks[id].isCompleted = !Global.tasks[id].isCompleted;
    });
  }

  void deleteTask({required int id}) {
    setState(() {
      Global.tasks.removeAt(id);
    });
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
                        const Color(0xFFD4E7FE),
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
                      color: const Color(0xFF272F66),
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
                            color: const Color(0xFF272F66),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          " ${DateTime.now().day} ${Global.months[DateTime.now().month - 1]}",
                          style: TextStyle(
                            color: const Color(0xFF272F66),
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
                    height: height - 191,
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
                                color: const Color(0xFF37408A),
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "(${Global.tasks.length})",
                              style: TextStyle(
                                color: const Color(0xFF37408A),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          flex: 4,
                          child: ListView.builder(
                            itemCount: Global.tasks.length,
                            itemBuilder: (BuildContext context, int idx) {
                              return TaskDetailCard(
                                id: idx,
                                deadLine: Global.tasks[idx].deadLine,
                                description: Global.tasks[idx].description,
                                isCompleted: Global.tasks[idx].isCompleted,
                                subject: Global.tasks[idx].subject,
                                updateTask: updateTask,
                                deleteTask: deleteTask,
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
              backgroundColor: Color(0xFF37408A),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTask(callback: addToAll),
                ),
              ),
              child: Icon(Icons.add_to_photos_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
