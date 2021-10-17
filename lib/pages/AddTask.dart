import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:remind_me/pages/UserOnboard.dart';

import 'package:remind_me/shared/LocalNotifications.dart';
import 'package:remind_me/providers/Tasks.dart';
import 'package:uuid/uuid.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final uuid = Uuid();
  int count = 1;
  String _subName = "";
  DateTime _deadLine = DateTime.now();
  String _description = "";
  LocalNotifications _localNotifications = LocalNotifications();

  @override
  void initState() {
    super.initState();
    _localNotifications.init();
    _localNotifications
        .configureSelectNotificationSubject(notificationSelected);
  }

  @override
  void dispose() {
    _localNotifications.dispose();
    super.dispose();
  }

  Future<void> notificationSelected() async {
    await Navigator.of(context).pushNamed("/onboard");
  }

  Widget _buildSubNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Subject Name",
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
      validator: (String? val) {
        if (val!.isEmpty) return "Provide a valid Input";
      },
      onSaved: (String? val) {
        _subName = val!;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Task Description",
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
      validator: (String? val) {
        if (val!.isEmpty) return "Provide a valid Input";
      },
      onSaved: (String? val) {
        _description = val!;
      },
    );
  }

  Widget _buildDeadLineField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Task Dead Line",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.blueGrey,
              ),
              onPressed: () {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (date) => setState(() => _deadLine = date),
                  currentTime: DateTime.now(),
                  locale: LocaleType.en,
                );
              },
            ),
          ],
        ),
        Row(
          children: [
            Text(
              _deadLine.toString().split(" ")[0],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              "${_deadLine.hour}:${_deadLine.minute}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final tasks = Provider.of<Tasks>(context);
    final snackBar = SnackBar(
      content:
          Text('You will receive a Notification 1 day before the DeadLine'),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[50],
        elevation: 0.0,
        actionsIconTheme: IconThemeData(color: Color(0xFF37408A)),
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "Add Task",
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
              const SizedBox(height: 10),
              _buildSubNameField(),
              const SizedBox(height: 10),
              _buildDescriptionField(),
              const SizedBox(height: 20),
              _buildDeadLineField(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  _formKey.currentState!.save();

                  tasks.addTask(
                    isCompleted: false,
                    subject: _subName,
                    deadLine: _deadLine.toString(),
                    description: _description,
                  );

                  _localNotifications.scheduleNotification(
                    date: _deadLine.subtract(
                      Duration(days: 1),
                    ),
                    channelId: uuid.v4(),
                    channelName: 'Task Channel',
                    channelDesc: 'Task Channel Description',
                    notificationTitle: 'Task Remainder',
                    notificationBody: '$_subName will be due in 24 hours',
                    payload: 'task',
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  primary: Color(0xFF3E37C9),
                ),
                child: Text(
                  "Add Task",
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
