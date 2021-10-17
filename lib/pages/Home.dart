import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/components/ClassCard.dart';
import 'package:remind_me/components/TaskCard.dart';
import 'package:remind_me/models/Subject.dart';
import 'package:remind_me/providers/MainState.dart';
import 'package:remind_me/providers/Subjects.dart';
import 'package:remind_me/providers/Tasks.dart';
import 'package:remind_me/shared/globals.dart';

class HomePage extends StatefulWidget {
  final Function pushToTasksPage;
  HomePage({required this.pushToTasksPage});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Subject> _subjectsToday = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      generate();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void generate() {
    final _subjects = Provider.of<Subjects>(context, listen: false).subjects;
    int curDay = DateTime.now().weekday - 1;
    List<Subject> _temp = [];

    _subjects
        .forEach((sub) => {if (sub.timeSlots[curDay] != null) _temp.add(sub)});

    _temp.sort(
      (a, b) => a.timeSlots[curDay]!.toString().compareTo(
            b.timeSlots[curDay]!.toString(),
          ),
    );

    setState(() => _subjectsToday = _temp);
  }

  int getDaysLeft(DateTime deadLine) {
    return deadLine.day - DateTime.now().day;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final tasks = Provider.of<Tasks>(context).tasks;
    final _mainStateProvider = Provider.of<MainState>(context);

    return SafeArea(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFD4E7FE),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        Global.days[DateTime.now().weekday - 1],
                        style: TextStyle(
                          color: Color(0xFF272F66),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        " ${DateTime.now().day} ${Global.months[DateTime.now().month - 1]}",
                        style: TextStyle(
                          color: Color(0xFF272F66),
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
                      _mainStateProvider.picPath.startsWith("assets")
                          ? Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.only(right: 20, left: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.withOpacity(0.2),
                                    blurRadius: 12,
                                    spreadRadius: 8,
                                  ),
                                ],
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(_mainStateProvider.picPath),
                                ),
                              ),
                            )
                          : Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.only(right: 20, left: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                    File(_mainStateProvider.picPath)),
                              ),
                            ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi, ${_mainStateProvider.userName}",
                              style: TextStyle(
                                color: Color(0xFF37408A),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Here is a list of you Schedule,",
                              style: TextStyle(
                                color: Color(0xFF37408A),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "You need to Check...",
                              style: TextStyle(
                                color: Color(0xFF37408A),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 180,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              height: height - 240,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "TODAY CLASSES ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "(${_subjectsToday.length})",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context)
                                    .pushNamed("/allSubjects"),
                                child: Text(
                                  "See all",
                                  style: TextStyle(
                                    color: Color(0xFF3F33C7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: _subjectsToday.length == 0
                                  ? Center(
                                      child: Text(
                                        "No classes for Today!!!",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: _subjectsToday.length <= 2
                                          ? _subjectsToday.length
                                          : 2,
                                      itemBuilder:
                                          (BuildContext context, int idx) {
                                        return ClassCard(
                                          time:
                                              "${_subjectsToday[idx].timeSlots[DateTime.now().weekday - 1]!.split(":")[0]}:${_subjectsToday[idx].timeSlots[DateTime.now().weekday - 1]!.split(":")[1]}",
                                          subjectName:
                                              _subjectsToday[idx].subjectName,
                                          roomName:
                                              _subjectsToday[idx].roomName,
                                          professorName:
                                              _subjectsToday[idx].professorName,
                                        );
                                      },
                                    ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "YOUR TASKS ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "(${tasks.length})",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    widget.pushToTasksPage();
                                  },
                                  child: Text(
                                    "See all",
                                    style: TextStyle(
                                      color: Color(0xFF3F33C7),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            child: tasks.length == 0
                                ? Center(
                                    child: Text(
                                      "No Due Tasks!!!",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tasks.length,
                                    itemBuilder:
                                        (BuildContext context, int idx) {
                                      return TaskCard(
                                        days: getDaysLeft(
                                          DateTime.parse(tasks[idx].deadLine),
                                        ),
                                        subjectName: tasks[idx].subject,
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
        ],
      ),
    );
  }
}
