import 'package:flutter/material.dart';
import 'package:remind_me/providers/Task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Tasks with ChangeNotifier {
  static const uid = Uuid();
  List<Task> _tasks = [];

  Tasks() {
    getData();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString('tasks');

    if (encodedData != null) {
      _tasks = Task.decode(encodedData);
      notifyListeners();
    }
  }

  void storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Task.encode(_tasks);
    prefs.setString('tasks', encodedData);
  }

  List<Task> get tasks {
    return [..._tasks];
  }

  void addTask({
    required bool isCompleted,
    required String subject,
    required String deadLine,
    required String description,
  }) {
    Task temp = Task(
      id: uid.v4(),
      isCompleted: isCompleted,
      subject: subject,
      deadLine: deadLine,
      description: description,
    );

    _tasks.add(temp);
    storeData();
    notifyListeners();
  }

  void removeTask({required String id}) {
    _tasks.removeWhere((element) => element.id == id);
    storeData();
    notifyListeners();
  }

  void markCompleted({required String id}) {
    _tasks.firstWhere((element) => element.id == id).isCompleted = true;
    storeData();
    notifyListeners();
  }

  void fromJSON(List<dynamic> data) {
    List<Task> temp = [];

    for (final tas in data) {
      Task task = Task(
        id: tas['id'],
        isCompleted: tas['isCompleted'],
        subject: tas['subject'],
        deadLine: tas['deadLine'],
        description: tas['description'],
      );

      temp.add(task);
    }

    _tasks = temp;
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> toJSON() async {
    List<Map<String, dynamic>> data = [];

    for (Task element in _tasks) {
      data.add({
        'id': element.id,
        'isCompleted': element.isCompleted,
        'subject': element.subject,
        'deadLine': element.deadLine,
        'description': element.description,
      });
    }

    return data;
  }
}
