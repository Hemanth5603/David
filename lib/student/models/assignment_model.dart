class AssignmentModel {
  AssignmentModel({
    required this.assignments,
    required this.status,
  });
  late final List<Assignments> assignments;
  late final bool status;

  AssignmentModel.fromJson(Map<String, dynamic> json) {
    assignments = List.from(json['assignments'])
        .map((e) => Assignments.fromJson(e))
        .toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['assignments'] = assignments.map((e) => e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class Assignments {
  Assignments({
    required this.id,
    required this.title,
    required this.description,
    required this.facultyId,
    required this.facultyName,
    required this.subject,
    required this.branch,
    required this.createdAt,
    required this.updatedAt,
    required this.dueDate,
    required this.status,
  });
  late final int id;
  late final String title;
  late final String description;
  late final int facultyId;
  late final String facultyName;
  late final String subject;
  late final String branch;
  late final String createdAt;
  late final String updatedAt;
  late final String dueDate;
  late final String status;

  Assignments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    facultyId = json['faculty_id'];
    facultyName = json['faculty_name'];
    subject = json['subject'];
    branch = json['branch'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dueDate = json['due_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['faculty_id'] = facultyId;
    _data['faculty_name'] = facultyName;
    _data['subject'] = subject;
    _data['branch'] = branch;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['due_date'] = dueDate;
    _data['status'] = status;
    return _data;
  }
}
