import 'package:flutter/material.dart';
import 'package:remind_me/models/Subject.dart';
import 'package:remind_me/providers/subjects_provider.dart';

class ClassesToday with ChangeNotifier {
  final SubjectsProvider? _subjectsProvider;
  List<Subject> _classesToday = [];

  ClassesToday(this._subjectsProvider) {
    if (_subjectsProvider != null)
      generateTodaysClasses(subjects: _subjectsProvider!.subjects);
  }

  List<Subject> get classesToday {
    return [..._classesToday];
  }

  void generateTodaysClasses({required List<Subject> subjects, int? day}) {
    int curDay = day == null ? DateTime.now().weekday - 1 : day;
    _classesToday = [];

    subjects.forEach(
        (sub) => {if (sub.timeSlots[curDay] != null) _classesToday.add(sub)});

    _classesToday.sort((a, b) => a.timeSlots[curDay]!
        .toString()
        .compareTo(b.timeSlots[curDay]!.toString()));

    notifyListeners();
  }
}
