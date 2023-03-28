import 'dart:convert';

class SubjectAttendance {
  String id;
  String subjectName;
  int classesAttended;
  int minRequiredClasses;
  int totalClassesCompleted;

  SubjectAttendance({
    required this.id,
    required this.subjectName,
    required this.totalClassesCompleted,
    required this.classesAttended,
    required this.minRequiredClasses,
  });

  factory SubjectAttendance.fromJson(Map<String, dynamic> jsonData) {
    return SubjectAttendance(
      id: jsonData['id'],
      subjectName: jsonData['subjectName'],
      minRequiredClasses: jsonData['minRequiredClasses'],
      classesAttended: jsonData['classesAttended'],
      totalClassesCompleted: jsonData['totalClassesCompleted'],
    );
  }

  static Map<String, dynamic> toMap(SubjectAttendance sub) => {
        'id': sub.id,
        'subjectName': sub.subjectName,
        'minRequiredClasses': sub.minRequiredClasses,
        'classesAttended': sub.classesAttended,
        'totalClassesCompleted': sub.totalClassesCompleted,
      };

  static String encode(List<SubjectAttendance> subjects) => json.encode(
        subjects
            .map<Map<String, dynamic>>((sub) => SubjectAttendance.toMap(sub))
            .toList(),
      );

  static List<SubjectAttendance> decode(String sub) =>
      (json.decode(sub) as List<dynamic>).map<SubjectAttendance>((item) {
        return SubjectAttendance.fromJson(item);
      }).toList();
}
