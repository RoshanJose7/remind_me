import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:remind_me/models/Subject.dart';

class Subjects with ChangeNotifier {
  static const uuid = Uuid();
  List<Subject> _subjects = [];

  Subjects() {
    getData();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString('subjects');

    if (encodedData != null) {
      _subjects = Subject.decode(encodedData);
      notifyListeners();
    }
  }

  void storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Subject.encode(_subjects);
    prefs.setString('subjects', encodedData);
  }

  List<Subject> get subjects {
    return [..._subjects];
  }

  void addSubject({
    required String duration,
    required String subjectName,
    required String professorName,
    required String roomName,
    required List timeSlots,
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
    storeData();
    notifyListeners();
  }

  void removeSubject({required String id}) {
    _subjects.removeWhere((sub) => sub.id == id);
    storeData();
    notifyListeners();
  }
}
