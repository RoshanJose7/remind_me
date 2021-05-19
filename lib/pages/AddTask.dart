import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import 'package:remind_me/providers/Tasks.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int count = 1;
  String _subName = "";
  DateTime _deadLine = DateTime.now();
  String _description = "";

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

  Widget _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Task Description"),
      validator: (String? val) {
        if (val!.isEmpty) return "Provide a valid Input";
      },
      onSaved: (String? val) {
        _description = val!;
      },
    );
  }

  Widget _buildDeadLineField() {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.deepPurple[400],
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onConfirm: (date) => _deadLine = date,
          currentTime: DateTime(2008, 12, 31, 23, 12, 34),
          locale: LocaleType.en,
        );
      },
      child: Text(
        'Select Task Dead-Line',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final tasks = Provider.of<Tasks>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[50],
        elevation: 0.0,
        actionsIconTheme: Theme.of(context).accentIconTheme,
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
              _buildSubNameField(),
              _buildDescriptionField(),
              const SizedBox(height: 20),
              _buildDeadLineField(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  _formKey.currentState!.save();

                  tasks.addTask(
                    isCompleted: false,
                    subject: _subName,
                    deadLine: _deadLine,
                    description: _description,
                  );

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
