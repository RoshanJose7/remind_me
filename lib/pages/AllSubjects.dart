import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/components/SubjectCard.dart';
import 'package:remind_me/providers/Subjects.dart';
import 'package:remind_me/shared/globals.dart';

class AllSubjects extends StatefulWidget {
  @override
  _AllSubjectsState createState() => _AllSubjectsState();
}

class _AllSubjectsState extends State<AllSubjects> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final subjects = Provider.of<Subjects>(context).subjects;
    final _theme = Theme.of(context);

    return SafeArea(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                          color: _theme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        " ${DateTime.now().day} ${Global.months[DateTime.now().month - 1]}",
                        style: TextStyle(
                          color: _theme.primaryColor,
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
                          "Your Subjects",
                          style: TextStyle(
                            color: _theme.primaryColor,
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
          Positioned(
            top: 120,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "All Subjects",
                          style: TextStyle(
                            color: _theme.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "(${subjects.length})",
                          style: TextStyle(
                            color: _theme.primaryColor,
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
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: subjects.length == 0
                        ? Center(
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
              backgroundColor: _theme.primaryColor,
              onPressed: () => Navigator.pushNamed(context, "/addSubject"),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
