import 'package:flutter/material.dart';
import 'package:remind_me/components/SubjectCard.dart';
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
                  margin: EdgeInsets.only(top: height * 0.03),
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
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              height: height - 180,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SingleChildScrollView(
                child: Container(
                  height: 500,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: Global.allSubjects.length,
                          itemBuilder: (ctx, idx) => SubjectCard(
                            duration: Global.allSubjects[idx].duration,
                            professorImg:
                                Global.allSubjects[idx].professorImage,
                            professorName:
                                Global.allSubjects[idx].professorName,
                            roomName: Global.allSubjects[idx].roomName,
                            subName: Global.allSubjects[idx].subjectName,
                            timeSlots: Global.allSubjects[idx].timeSlots,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
