import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_me/components/AddSubject.dart';
import 'package:remind_me/components/SubjectCard.dart';
import 'package:remind_me/providers/Subjects.dart';
import 'package:remind_me/shared/globals.dart';

class AllSubjects extends StatefulWidget {
  @override
  _AllSubjectsState createState() => _AllSubjectsState();
}

class _AllSubjectsState extends State<AllSubjects>
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final subjects = Provider.of<Subjects>(context).subjects;
    final _theme = Theme.of(context);

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
                          "Subjects",
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
            padding: EdgeInsets.only(top: 20, bottom: 10),
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
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else if (_controller.isCompleted) {
                _controller.reverse();
              }
            },
            child: Icon(
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
                          Border.all(color: _theme.backgroundColor, width: 5),
                      borderRadius: BorderRadius.only(
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
                              icon: Icon(
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
                                color: _theme.cardColor,
                              ),
                            ),
                          ],
                        ),
                        AddSubject(),
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
