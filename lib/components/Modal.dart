import 'package:flutter/material.dart';
import 'package:remind_me/models/Subject.dart';
import 'package:remind_me/shared/globals.dart';

List<dynamic> _timeSlots = [];

// ignore: must_be_immutable
class TimeSlot extends StatelessWidget {
  int idx;
  TimeSlot(this.idx);

  @override
  Widget build(BuildContext context) {
    TextEditingController _time = TextEditingController();

    if (_time.value.toString() != 'null')
      _timeSlots.add(_time.value.toString());

    return Row(
      children: [
        Text("Time for ${Global.days[idx]}"),
        TextField(
          controller: _time,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class Modal extends StatefulWidget {
  @override
  _ModalState createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  TextEditingController _subjectName = TextEditingController();
  TextEditingController _duration = TextEditingController();
  TextEditingController _professorName = TextEditingController();
  TextEditingController _professorImage = TextEditingController();
  TextEditingController _roomName = TextEditingController();

  int count = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = new List.generate(count, (int i) => TimeSlot(i));
    return SafeArea(
      child: Scaffold(
        body: Container(
          constraints: BoxConstraints(maxHeight: 700),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Subject Name"),
                TextField(
                  controller: _subjectName,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Professor Name"),
                TextField(
                  controller: _professorName,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Professor Image"),
                TextField(
                  controller: _professorImage,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Room Name"),
                TextField(
                  controller: _roomName,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Duration"),
                TextField(
                  controller: _duration,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: children,
                ),
                Row(
                  children: [
                    Text("Add Time Slot"),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        print("clicked : $count");
                        if (count < 7) {
                          setState(() {
                            count = count + 1;
                          });
                        }
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    Subject temp = Subject(
                      duration: _duration.value.toString(),
                      subjectName: _subjectName.value.toString(),
                      professorImage: _professorImage.value.toString(),
                      professorName: _professorName.value.toString(),
                      roomName: _roomName.value.toString(),
                      timeSlots: _timeSlots,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
