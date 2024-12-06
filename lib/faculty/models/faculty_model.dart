class FacultyModel {
  FacultyModel({
    required this.faculty,
    required this.status,
  });
  late final Faculty faculty;
  late final bool status;

  FacultyModel.fromJson(Map<String, dynamic> json) {
    faculty = Faculty.fromJson(json['faculty']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['faculty'] = faculty.toJson();
    _data['status'] = status;
    return _data;
  }
}

class Faculty {
  Faculty({
    required this.facultyId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.department,
    required this.designation,
    required this.joiningDate,
    required this.address,
    required this.dateOfBirth,
    required this.gender,
    required this.qualification,
    required this.branch,
    required this.createdAt,
    required this.updatedAt,
    required this.password,
  });
  late final int facultyId;
  late final String name;
  late final String email;
  late final String phoneNumber;
  late final String department;
  late final String designation;
  late final String joiningDate;
  late final String address;
  late final String dateOfBirth;
  late final String gender;
  late final String qualification;
  late final String branch;
  late final String createdAt;
  late final String updatedAt;
  late final String password;

  Faculty.fromJson(Map<String, dynamic> json) {
    facultyId = json['faculty_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    department = json['department'];
    designation = json['designation'];
    joiningDate = json['joining_date'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    qualification = json['qualification'];
    branch = json['branch'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['faculty_id'] = facultyId;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone_number'] = phoneNumber;
    _data['department'] = department;
    _data['designation'] = designation;
    _data['joining_date'] = joiningDate;
    _data['address'] = address;
    _data['date_of_birth'] = dateOfBirth;
    _data['gender'] = gender;
    _data['qualification'] = qualification;
    _data['branch'] = branch;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['password'] = password;
    return _data;
  }
}
