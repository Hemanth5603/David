class AssignmentSubmissionModel {
  AssignmentSubmissionModel({
    required this.status,
    required this.submissions,
  });
  late final bool status;
  late final List<Submissions> submissions;

  AssignmentSubmissionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    submissions = List.from(json['submissions'])
        .map((e) => Submissions.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['submissions'] = submissions.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Submissions {
  Submissions({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.branch,
    required this.subjectName,
    required this.assignmentTitle,
    required this.submissionDate,
    required this.pdfUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String studentId;
  late final String studentName;
  late final String branch;
  late final String subjectName;
  late final String assignmentTitle;
  late final String submissionDate;
  late final String pdfUrl;
  late final String status;
  late final String createdAt;
  late final String updatedAt;

  Submissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    studentName = json['student_name'];
    branch = json['branch'];
    subjectName = json['subject_name'];
    assignmentTitle = json['assignment_title'];
    submissionDate = json['submission_date'];
    pdfUrl = json['pdf_url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['student_id'] = studentId;
    _data['student_name'] = studentName;
    _data['branch'] = branch;
    _data['subject_name'] = subjectName;
    _data['assignment_title'] = assignmentTitle;
    _data['submission_date'] = submissionDate;
    _data['pdf_url'] = pdfUrl;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
