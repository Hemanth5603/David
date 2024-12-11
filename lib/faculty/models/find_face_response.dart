class FindFaceResponse {
  FindFaceResponse({
    required this.roll,
    required this.branch,
    required this.name,
  });
  late final String roll;
  late final String branch;
  late final String name;

  FindFaceResponse.fromJson(Map<String, dynamic> json) {
    roll = json['roll'];
    branch = json['branch'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['roll'] = roll;
    _data['branch'] = branch;
    _data['name'] = name;
    return _data;
  }
}
