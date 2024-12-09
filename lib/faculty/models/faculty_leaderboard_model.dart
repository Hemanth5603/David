class FacultyLeaderBoardModel {
  final List<FacultyMetric> metrics;
  final bool status;

  FacultyLeaderBoardModel({
    required this.metrics,
    required this.status,
  });

  factory FacultyLeaderBoardModel.fromJson(Map<String, dynamic> json) {
    return FacultyLeaderBoardModel(
      metrics:
          (json['data'] as List).map((x) => FacultyMetric.fromJson(x)).toList(),
      status: json['status'],
    );
  }
}

class FacultyMetric {
  final int facultyId;
  final String facultyName;
  final String department;
  final int lectureHours;
  final double syllabusCompletionRate;
  final double averageAttendanceRate;
  final double studentRating;
  final int researchPapersPublished;
  final int workshopsConducted;
  final double overallScore;
  final DateTime lastReviewDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  FacultyMetric({
    required this.facultyId,
    required this.facultyName,
    required this.department,
    required this.lectureHours,
    required this.syllabusCompletionRate,
    required this.averageAttendanceRate,
    required this.studentRating,
    required this.researchPapersPublished,
    required this.workshopsConducted,
    required this.overallScore,
    required this.lastReviewDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FacultyMetric.fromJson(Map<String, dynamic> json) {
    return FacultyMetric(
      facultyId: json['faculty_id'] as int,
      facultyName: json['faculty_name'] as String,
      department: json['department'] as String,
      lectureHours: json['lecture_hours'] as int,
      syllabusCompletionRate: (json['syllabus_completion_rate'] is int)
          ? (json['syllabus_completion_rate'] as int).toDouble()
          : json['syllabus_completion_rate'] as double,
      averageAttendanceRate: (json['average_attendance_rate'] is int)
          ? (json['average_attendance_rate'] as int).toDouble()
          : json['average_attendance_rate'] as double,
      studentRating: (json['student_rating'] is int)
          ? (json['student_rating'] as int).toDouble()
          : json['student_rating'] as double,
      researchPapersPublished: json['research_papers_published'] as int,
      workshopsConducted: json['workshops_conducted'] as int,
      overallScore: (json['overall_score'] is int)
          ? (json['overall_score'] as int).toDouble()
          : json['overall_score'] as double,
      lastReviewDate: DateTime.parse(json['last_review_date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
