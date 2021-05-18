import 'package:flutter/material.dart';
import 'package:remind_me/models/Subject.dart';
import 'package:uuid/uuid.dart';

class Subjects with ChangeNotifier {
  static const uuid = Uuid();

  List<Subject> _subjects = [
    Subject(
      id: uuid.v4(),
      duration: "1 hr",
      subjectName: "Data Structures and Algorithms",
      professorName: "Gabriel Sutton",
      roomName: "Computer Science Engineering:Room C1, 2nd floor",
      timeSlots: [
        null,
        TimeOfDay(hour: 8, minute: 0),
        null,
        null,
        null,
        TimeOfDay(hour: 12, minute: 0),
        null,
      ],
    ),
    Subject(
      id: uuid.v4(),
      duration: "1 hr 30 min",
      subjectName: "Internet of Things",
      professorName: "Stella Varghese",
      roomName: "Electronics and Communication:Room A3, 2nd floor",
      timeSlots: [
        null,
        TimeOfDay(hour: 09, minute: 0),
        TimeOfDay(hour: 10, minute: 0),
        null,
        null,
        TimeOfDay(hour: 15, minute: 0),
        null,
      ],
    ),
    Subject(
      id: uuid.v4(),
      duration: "1 hr 45 min",
      subjectName: "Engineering Mathematics",
      professorName: "Alexander Andrio",
      roomName: "Engineering Mathematics:Room B4, 2st floor",
      timeSlots: [
        null,
        TimeOfDay(hour: 08, minute: 0),
        null,
        null,
        TimeOfDay(hour: 10, minute: 10),
        null,
        null,
      ],
    ),
  ];

  List<Subject> get subjects {
    return [..._subjects];
  }

  void addSubject({
    required String duration,
    required String subjectName,
    required String professorName,
    required String roomName,
    required List<TimeOfDay?> timeSlots,
  }) {
    _subjects.add(
      Subject(
        id: uuid.v4(),
        duration: duration,
        subjectName: subjectName,
        professorName: professorName,
        roomName: roomName,
        timeSlots: timeSlots,
      ),
    );
    notifyListeners();
  }

  void removeSubject({required String id}) {
    _subjects.removeWhere((sub) => sub.id == id);
    notifyListeners();
  }
}
