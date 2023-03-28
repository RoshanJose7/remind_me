import 'dart:convert';

class Subject {
  String id;
  String duration;
  String subjectName;
  String professorName;
  String roomName;
  List timeSlots;

  Subject({
    required this.id,
    required this.duration,
    required this.subjectName,
    required this.professorName,
    required this.roomName,
    required this.timeSlots,
  });

  factory Subject.fromJson(Map<String, dynamic> jsonData) {
    return Subject(
      id: jsonData['id'],
      duration: jsonData['duration'],
      subjectName: jsonData['subjectName'],
      professorName: jsonData['professorName'],
      roomName: jsonData['roomName'],
      timeSlots: jsonData['timeSlots'],
    );
  }

  static Map<String, dynamic> toMap(Subject sub) => {
        'id': sub.id,
        'duration': sub.duration,
        'subjectName': sub.subjectName,
        'professorName': sub.professorName,
        'roomName': sub.roomName,
        'timeSlots': sub.timeSlots,
      };

  static String encode(List<Subject> subjects) => json.encode(
        subjects
            .map<Map<String, dynamic>>((sub) => Subject.toMap(sub))
            .toList(),
      );

  static List<Subject> decode(String sub) => (json.decode(sub) as List<dynamic>)
      .map<Subject>((item) => Subject.fromJson(item))
      .toList();
}
