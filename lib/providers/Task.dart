import 'package:flutter/material.dart';

class Task with ChangeNotifier {
  bool isCompleted;
  String id;
  String subject;
  String description;
  DateTime deadLine;

  Task({
    required this.id,
    required this.isCompleted,
    required this.subject,
    required this.deadLine,
    required this.description,
  });

  void toggleIsCompleted() {
    isCompleted = !isCompleted;
    notifyListeners();
  }
}
