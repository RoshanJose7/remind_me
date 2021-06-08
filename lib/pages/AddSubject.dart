import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:remind_me/providers/Subjects.dart';
import 'package:remind_me/shared/LocalNotifications.dart';
import 'package:remind_me/shared/globals.dart';

class AddSubject extends StatefulWidget {
  @override
  _AddSubjectState createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LocalNotifications _localNotifications = LocalNotifications();
  int count = 1;
  String _subName = "";
  String _duration = "";
  String _professorName = "";
  String _roomFloor = "";
  String _roomName = "";
  List<String?> _timeSlots = [];

  Widget _buildSubNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Subject Name"),
      validator: (String? val) {
        if (val!.isEmpty) return "Provide a valid Input";
      },
      onSaved: (String? val) {
        _subName = val!;
      },
    );
  }

  Widget _buildProfessorNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Professor Name"),
      validator: (String? val) {
        if (val!.isEmpty) return "Provide a valid Input";
      },
      onSaved: (String? val) {
        _professorName = val!;
      },
    );
  }

  Widget _buildDurationField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Duration (Format : xhr xxmin)"),
      validator: (String? val) {
        if (val!.isEmpty) return "Provide a valid Input";
      },
      onSaved: (String? val) {
        _duration = val!;
      },
    );
  }

  Widget _buildRoomFloorField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Room Floor"),
      validator: (String? val) {
        if (val!.isEmpty) return "Provide a valid Input";
      },
      onSaved: (String? val) {
        _roomFloor = val!;
      },
    );
  }

  Widget _buildRoomNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Room Name"),
      validator: (String? val) {
        if (val!.isEmpty) return "Provide a valid Input";
      },
      onSaved: (String? val) {
        _roomName = val!;
      },
    );
  }

  Widget _buildTimeSlotField(int i) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: Global.days[i],
        labelStyle: TextStyle(fontSize: 15),
      ),
      onSaved: (String? val) {
        if (val != null && val.isNotEmpty)
          _timeSlots.add(
              "${val.split(":")[0]}:${val.split(":")[1] == '0' ? 00 : val.split(":")[1]}");
        else
          _timeSlots.add(null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final subjectProvider = Provider.of<Subjects>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[50],
        elevation: 0.0,
        actionsIconTheme: Theme.of(context).accentIconTheme,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "Add Subject",
          style: TextStyle(
            fontFamily: "Righteous",
            fontSize: 24,
            color: Colors.black45,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildSubNameField(),
                _buildDurationField(),
                _buildProfessorNameField(),
                _buildRoomFloorField(),
                _buildRoomNameField(),
                Container(
                  width: width - 50,
                  height: height - 470,
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    children: [
                      Text(
                        "Time Slot 24 Hour Text Format hh:mm",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "(Leave blank if no class)",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      for (int i = 0; i < count && count <= 7; i++)
                        _buildTimeSlotField(i),
                      if (count < 7)
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(
                              () {
                                count++;
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();

                    for (int i = _timeSlots.length - 1; i < 7; i++)
                      _timeSlots.add(null);

                    subjectProvider.addSubject(
                      duration: _duration,
                      subjectName: _subName,
                      professorName: _professorName,
                      roomName: "$_roomName:$_roomFloor",
                      timeSlots: _timeSlots,
                    );

                    _timeSlots.map((_slot) async => {
                          if (_slot != null)
                            await _localNotifications
                                .scheduleAtDayAndTimeNotification(
                                    date: DateTime.parse(_slot))
                        });

                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    primary: Color(0xFF3E37C9),
                  ),
                  child: Text(
                    "Add Subject",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
