class StudentModel {
  StudentModel({
    required this.status,
    required this.student,
  });
  late final bool status;
  late final Student student;

  StudentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    student = Student.fromJson(json['student']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['student'] = student.toJson();
    return _data;
  }
}

class Student {
  Student({
    required this.studentId,
    required this.rollNo,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.branch,
    required this.section,
    required this.yearOfStudy,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int studentId;
  late final String rollNo;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phoneNumber;
  late final String dateOfBirth;
  late final String gender;
  late final String address;
  late final String branch;
  late final String section;
  late final int yearOfStudy;
  late final String password;
  late final String createdAt;
  late final String updatedAt;

  Student.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    rollNo = json['roll_no'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    address = json['address'];
    branch = json['branch'];
    section = json['section'];
    yearOfStudy = json['year_of_study'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['student_id'] = studentId;
    _data['roll_no'] = rollNo;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['phone_number'] = phoneNumber;
    _data['date_of_birth'] = dateOfBirth;
    _data['gender'] = gender;
    _data['address'] = address;
    _data['branch'] = branch;
    _data['section'] = section;
    _data['year_of_study'] = yearOfStudy;
    _data['password'] = password;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
