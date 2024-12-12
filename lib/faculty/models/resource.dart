class ResourceAllocation {
  ResourceAllocation({
    required this.requests,
    required this.status,
  });
  late final List<Requests> requests;
  late final bool status;

  ResourceAllocation.fromJson(Map<String, dynamic> json) {
    requests =
        List.from(json['requests']).map((e) => Requests.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['requests'] = requests.map((e) => e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class Requests {
  Requests({
    required this.id,
    required this.facultyName,
    required this.resourceType,
    required this.subType,
    required this.timeSlot,
    required this.branch,
    required this.status,
    required this.createdAt,
  });
  late final int id;
  late final String facultyName;
  late final String resourceType;
  late final String subType;
  late final String timeSlot;
  late final String branch;
  late final int status;
  late final String createdAt;

  Requests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facultyName = json['faculty_name'];
    resourceType = json['resource_type'];
    subType = json['sub_type'];
    timeSlot = json['time_slot'];
    branch = json['branch'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['faculty_name'] = facultyName;
    _data['resource_type'] = resourceType;
    _data['sub_type'] = subType;
    _data['time_slot'] = timeSlot;
    _data['branch'] = branch;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    return _data;
  }
}
