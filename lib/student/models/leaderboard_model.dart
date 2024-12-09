class StudentLeaderBoardModel {
  StudentLeaderBoardModel({
    required this.data,
    required this.status,
  });
  late final Data data;
  late final bool status;

  StudentLeaderBoardModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data({
    required this.rankings,
    required this.totalStudents,
  });
  late final List<Rankings> rankings;
  late final int totalStudents;

  Data.fromJson(Map<String, dynamic> json) {
    rankings =
        List.from(json['rankings']).map((e) => Rankings.fromJson(e)).toList();
    totalStudents = json['total_students'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['rankings'] = rankings.map((e) => e.toJson()).toList();
    _data['total_students'] = totalStudents;
    return _data;
  }
}

class Rankings {
  Rankings({
    required this.id,
    required this.rollNo,
    required this.cgpa,
    required this.attendancePercentage,
    required this.extracurricularCount,
    required this.awardsCount,
    required this.totalCredits,
    required this.lastUpdated,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.branch,
    required this.section,
    required this.rank,
  });
  late final int id;
  late final String rollNo;
  late final double cgpa;
  late final double attendancePercentage;
  late final int extracurricularCount;
  late final int awardsCount;
  late final int totalCredits;
  late final String lastUpdated;
  late final String createdAt;
  late final String firstName;
  late final String lastName;
  late final String branch;
  late final String section;
  late final int rank;

  Rankings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rollNo = json['roll_no'];
    cgpa = json['cgpa'];
    attendancePercentage = json['attendance_percentage'];
    extracurricularCount = json['extracurricular_count'];
    awardsCount = json['awards_count'];
    totalCredits = json['total_credits'];
    lastUpdated = json['last_updated'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    branch = json['branch'];
    section = json['section'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['roll_no'] = rollNo;
    _data['cgpa'] = cgpa;
    _data['attendance_percentage'] = attendancePercentage;
    _data['extracurricular_count'] = extracurricularCount;
    _data['awards_count'] = awardsCount;
    _data['total_credits'] = totalCredits;
    _data['last_updated'] = lastUpdated;
    _data['created_at'] = createdAt;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['branch'] = branch;
    _data['section'] = section;
    _data['rank'] = rank;
    return _data;
  }
}
