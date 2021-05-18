import 'package:flutter/material.dart';
import 'package:remind_me/providers/Task.dart';
import 'package:uuid/uuid.dart';

class Tasks with ChangeNotifier {
  static const uid = Uuid();

  List<Task> _tasks = [
    Task(
      id: uid.v4(),
      isCompleted: false,
      subject: "Engineering Mathematics",
      description: "Assignment I - Second Order Differential Equations",
      deadLine: DateTime(2021, 5, 18, 10, 30),
    ),
    Task(
      id: uid.v4(),
      isCompleted: true,
      subject: "Data Structures and Algorithms",
      description: "DS and Algo Lab Record",
      deadLine: DateTime(2021, 5, 27, 10, 30),
    ),
    Task(
      id: uid.v4(),
      isCompleted: true,
      subject: "Internet of Things",
      description: "IOT Internals I",
      deadLine: DateTime(2021, 5, 28, 10, 30),
    ),
  ];

  List<Task> get tasks {
    return [..._tasks];
  }

  void addTask({
    required bool isCompleted,
    required String subject,
    required DateTime deadLine,
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
    notifyListeners();
  }

  void removeTask({required String id}) {
    _tasks.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void markCompleted({required String id}) {
    _tasks.firstWhere((element) => element.id == id).isCompleted = true;
    notifyListeners();
  }
}
