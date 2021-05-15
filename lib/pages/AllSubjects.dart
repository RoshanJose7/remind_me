import 'package:flutter/material.dart';
import 'package:remind_me/components/SubjectCard.dart';
import 'package:remind_me/models/Subject.dart';
import 'package:remind_me/pages/AddSubject.dart';
import 'package:remind_me/shared/globals.dart';

class AllSubjects extends StatefulWidget {
  @override
  _AllSubjectsState createState() => _AllSubjectsState();
}

class _AllSubjectsState extends State<AllSubjects> {
  void addToAll({required Subject sub}) {
    setState(() {
      Global.allSubjects.add(sub);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(color: Colors.blueGrey[50]),
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
                      Expanded(
                        child: Text(
                          "All Your Subjects",
                          style: TextStyle(
                            color: Color(0xFF37408A),
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
              child: Container(
                height: height,
                width: width,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: ListView.builder(
                  itemCount: Global.allSubjects.length,
                  itemBuilder: (ctx, idx) {
                    return SubjectCard(
                      duration: Global.allSubjects[idx].duration,
                      professorName: Global.allSubjects[idx].professorName,
                      roomName: Global.allSubjects[idx].roomName,
                      subName: Global.allSubjects[idx].subjectName,
                      timeSlots: Global.allSubjects[idx].timeSlots,
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSubject(callback: addToAll),
                ),
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
