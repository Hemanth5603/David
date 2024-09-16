class StudentModel {
  StudentModel({
    this.status,
    this.id,
    this.name,
    this.branch,
    this.phone,
    this.roll,
    this.academic,
    this.semester,
    this.section,
  });
  String? status;
  int? id;
  String? name;
  String? branch;
  String? phone;
  String? roll;
  int? academic;
  int? semester;
  String? section;
  
  StudentModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    id = json['Id'];
    name = json['Name'];
    branch = json['Branch'];
    phone = json['Phone'];
    roll = json['Roll'];
    academic = json['Academic'];
    semester = json['Semester'];
    section = json['Section'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['Id'] = id;
    _data['Name'] = name;
    _data['Branch'] = branch;
    _data['Phone'] = phone;
    _data['Roll'] = roll;
    _data['Academic'] = academic;
    _data['Semester'] = semester;
    _data['Section'] = section;
    return _data;
  }
}