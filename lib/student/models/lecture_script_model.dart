class LectureScript {
  LectureScript({
    required this.data,
    required this.status,
  });
  late final List<Data> data;
  late final bool status;

  LectureScript.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.facultyId,
    required this.branch,
    required this.title,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
    required this.topics,
    required this.lectureId,
  });
  late final int id;
  late final int facultyId;
  late final String branch;
  late final String title;
  late final String filePath;
  late final String createdAt;
  late final String updatedAt;
  late final String topics;
  late final String lectureId;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facultyId = json['faculty_id'];
    branch = json['branch'];
    title = json['title'];
    filePath = json['file_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    topics = json['topics'];
    lectureId = json['lecture_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['faculty_id'] = facultyId;
    _data['branch'] = branch;
    _data['title'] = title;
    _data['file_path'] = filePath;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['topics'] = topics;
    _data['lecture_id'] = lectureId;
    return _data;
  }
}
