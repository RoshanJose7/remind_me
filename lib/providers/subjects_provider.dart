import 'package:flutter/material.dart';
import 'package:remind_me/models/Subject.dart';
import 'package:remind_me/models/SubjectAttendance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SubjectsProvider with ChangeNotifier {
  static const uuid = Uuid();
  List<Subject> _subjects = [];
  List<SubjectAttendance> _subjectAttendance = [];

  SubjectsProvider() {
    getData();
  }

  List<Subject> get subjects {
    return [..._subjects];
  }

  List<SubjectAttendance> get subjectsAttendance {
    return [..._subjectAttendance];
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedSubjectsData = prefs.getString('subjects');

    String? encodedSubjectsAttendanceData =
        prefs.getString('subjectsAttendance');

    if (encodedSubjectsData != null) {
      _subjects = Subject.decode(encodedSubjectsData);
      notifyListeners();
    }

    if (encodedSubjectsAttendanceData != null) {
      _subjectAttendance =
          SubjectAttendance.decode(encodedSubjectsAttendanceData);
      notifyListeners();
    }
  }

  void storeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Subject.encode(_subjects);
    final String encodedData1 = SubjectAttendance.encode(_subjectAttendance);

    prefs.setString('subjectsAttendance', encodedData1);
    prefs.setString('subjects', encodedData);
  }

  Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await getData();
  }

  void addSubject({
    required String duration,
    required String subjectName,
    required int minRequiredClasses,
    required int totalClassesCompleted,
    required int classesAttended,
    required String professorName,
    required String roomName,
    required List timeSlots,
  }) {
    String id = uuid.v4();

    _subjects.add(
      Subject(
        id: id,
        duration: duration,
        subjectName: subjectName,
        professorName: professorName,
        roomName: roomName,
        timeSlots: timeSlots,
      ),
    );

    print(totalClassesCompleted);
    print(classesAttended);

    _subjectAttendance.add(
      SubjectAttendance(
        id: uuid.v4(),
        subjectName: subjectName,
        minRequiredClasses: minRequiredClasses,
        totalClassesCompleted: totalClassesCompleted,
        classesAttended: classesAttended,
      ),
    );

    notifyListeners();
    storeData();
  }

  void updateClasses({
    required String id,
    required int totalClasses,
    required int attendedClasses,
  }) {
    int idx = _subjectAttendance.indexWhere((element) => element.id == id);

    _subjectAttendance[idx].totalClassesCompleted = totalClasses;
    _subjectAttendance[idx].classesAttended = attendedClasses;

    notifyListeners();
    storeData();
  }

  void removeSubject({required String id}) {
    _subjects.removeWhere((sub) => sub.id == id);
    _subjectAttendance.removeWhere((sub) => sub.id == id);

    notifyListeners();
    storeData();
  }

  int calcMinimumClassesRequired(
      {required int totalClasses, required double attendancePercent}) {
    return ((attendancePercent * totalClasses) / 100).round();
  }

  double calcPercentage(
      {required int totalClasses, required int classesAttended}) {
    print("totalClasses $totalClasses");
    print("classesAttended $classesAttended");

    return (classesAttended / totalClasses) * 100;
  }

  void fromJSON(List<dynamic> data) {
    List<Subject> temp = [];

    for (final sub in data) {
      Subject subject = Subject(
        id: sub['id'],
        duration: sub['duration'],
        subjectName: sub['subjectName'],
        professorName: sub['professorName'],
        roomName: sub['roomName'],
        timeSlots: sub['timeSlots'],
      );

      temp.add(subject);
    }

    _subjects = temp;
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> toJSON() async {
    List<Map<String, dynamic>> data = [];

    for (Subject element in _subjects) {
      data.add({
        'id': element.id,
        'duration': element.duration,
        'subjectName': element.subjectName,
        'professorName': element.professorName,
        'roomName': element.roomName,
        'timeSlots': element.timeSlots,
      });
    }

    return data;
  }
}
