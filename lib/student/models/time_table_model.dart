class TimeTableModel {
  TimeTableModel({
    required this.status,
    required this.timetables,
  });
  late final bool status;
  late final List<Timetables> timetables;

  TimeTableModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    timetables = List.from(json['timetables'])
        .map((e) => Timetables.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['timetables'] = timetables.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Timetables {
  Timetables({
    required this.day,
    required this.classes,
  });
  late final String day;
  late final List<Classes> classes;

  Timetables.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    classes =
        List.from(json['classes']).map((e) => Classes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['classes'] = classes.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Classes {
  Classes({
    required this.room,
    required this.time,
    required this.subjectName,
    required this.teacherName,
  });
  late final String room;
  late final String time;
  late final String subjectName;
  late final String teacherName;

  Classes.fromJson(Map<String, dynamic> json) {
    room = json['room'];
    time = json['time'];
    subjectName = json['subject_name'];
    teacherName = json['teacher_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['room'] = room;
    _data['time'] = time;
    _data['subject_name'] = subjectName;
    _data['teacher_name'] = teacherName;
    return _data;
  }
}
