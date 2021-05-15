import 'package:flutter/material.dart';

class Subject {
  late String duration;
  late String subjectName;
  late String professorName;
  late String roomName;
  late List<TimeOfDay?> timeSlots;

  Subject({
    required this.duration,
    required this.subjectName,
    required this.professorName,
    required this.roomName,
    required this.timeSlots,
  });
}
