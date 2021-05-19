import 'package:flutter/material.dart';
import 'dart:convert';

class Task with ChangeNotifier {
  bool isCompleted;
  String id;
  String subject;
  String description;
  String deadLine;

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

  factory Task.fromJson(Map<String, dynamic> jsonData) {
    return Task(
      id: jsonData['id'],
      isCompleted: jsonData['isCompleted'],
      subject: jsonData['subject'],
      deadLine: jsonData['deadLine'],
      description: jsonData['description'],
    );
  }

  static Map<String, dynamic> toMap(Task task) => {
        'id': task.id,
        'isCompleted': task.isCompleted,
        'subject': task.subject,
        'deadLine': task.deadLine,
        'description': task.description,
      };

  static String encode(List<Task> tasks) => json.encode(
        tasks.map<Map<String, dynamic>>((sub) => Task.toMap(sub)).toList(),
      );

  static List<Task> decode(String task) => (json.decode(task) as List<dynamic>)
      .map<Task>((item) => Task.fromJson(item))
      .toList();
}
