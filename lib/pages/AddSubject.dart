import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
  int _hours = 00, _minutes = 00;
  String _professorName = "";
  String _roomFloor = "";
  String _roomName = "";
  List<String?> _timeSlots = [];

  Widget _buildSubNameField() => TextFormField(
        decoration: InputDecoration(
          labelText: "Subject Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
        validator: (String? val) {
          if (val!.isEmpty) return "Provide a valid Input";
        },
        onSaved: (String? val) {
          _subName = val!;
        },
      );

  Widget _buildProfessorNameField() => TextFormField(
        decoration: InputDecoration(
          labelText: "Professor Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
        validator: (String? val) {
          if (val!.isEmpty) return "Provide a valid Input";
        },
        onSaved: (String? val) => _professorName = val!,
      );

  Widget _buildDurationField() => Row(
        children: [
          Text(
            "Duration",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 20),
          Container(
            width: 70,
            child: TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.datetime,
              onChanged: (val) => _hours = int.parse(val),
              validator: (val) {
                if (val == null)
                  return "Enter a valid number";
                else if (int.tryParse(val) == 0) return "Hour cannot be 0";
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Hours',
                labelStyle: TextStyle(color: Colors.blueGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Container(
            width: 80,
            child: TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.datetime,
              onChanged: (val) => _minutes = int.parse(val),
              validator: (val) {
                if (val == null) return "Enter a valid number";
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'Minutes',
                labelStyle: TextStyle(color: Colors.blueGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
          ),
        ],
      );

  Widget _buildRoomFloorField() => TextFormField(
        decoration: InputDecoration(
          labelText: "Room Floor",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
        validator: (String? val) {
          if (val!.isEmpty) return "Provide a valid Input";
        },
        onSaved: (String? val) => _roomFloor = val!,
      );

  Widget _buildRoomNameField() => TextFormField(
        decoration: InputDecoration(
          labelText: "Room Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
        validator: (String? val) {
          if (val!.isEmpty) return "Provide a valid Input";
        },
        onSaved: (String? val) {
          _roomName = val!;
        },
      );

  Widget _buildTimeSlotField(int i) {
    setState(() {
      _timeSlots.add(null);
    });

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 2,
          ),
          top: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 2,
          ),
          left: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 2,
          ),
          right: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 2,
          ),
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Global.days[i],
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 65),
              Text(
                i > _timeSlots.length - 1 || _timeSlots[i] == null
                    ? "No Class"
                    : "${_timeSlots[i]!}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  DatePicker.showTimePicker(
                    context,
                    showTitleActions: true,
                    onConfirm: (date) => setState(() => _timeSlots[i] =
                        "${date.toString().split(" ")[1].split(":")[0]}:${date.toString().split(" ")[1].split(":")[1] == '0' ? 00 : date.toString().split(" ")[1].split(":")[1]}"),
                    currentTime: DateTime(2021, 12, 12, 09, 41, 00),
                    locale: LocaleType.en,
                  );
                },
                child: Text("Pick Time"),
              ),
              const SizedBox(width: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () => setState(() => _timeSlots[i] = null),
                child: Text("No Class"),
              ),
            ],
          ),
        ],
      ),
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
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildSubNameField(),
              const SizedBox(height: 10),
              _buildProfessorNameField(),
              const SizedBox(height: 10),
              _buildRoomFloorField(),
              const SizedBox(height: 10),
              _buildRoomNameField(),
              const SizedBox(height: 10),
              _buildDurationField(),
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
                      "Select Your Time Slots",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Day",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 80),
                        Text(
                          "Date",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    for (int i = 0; i < count && count <= 7; i++)
                      _buildTimeSlotField(i),
                    if (count < 7)
                      TextButton(
                        child: Text(
                          "Add Day",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                    duration: "${_hours}hr ${_minutes}min",
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
    );
  }
}
