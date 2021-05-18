import 'package:flutter/material.dart';

class Subject {
  String id;
  String duration;
  String subjectName;
  String professorName;
  String roomName;
  List<TimeOfDay?> timeSlots;

  Subject({
    required this.id,
    required this.duration,
    required this.subjectName,
    required this.professorName,
    required this.roomName,
    required this.timeSlots,
  });
}
