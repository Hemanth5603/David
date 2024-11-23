class AttendanceResponseModel {
  AttendanceResponseModel({
    required this.rolls,
    required this.presents,
    required this.absents,
  });
  late final List<String> rolls;
  late final List<String> presents;
  late final List<String> absents;
  
  AttendanceResponseModel.fromJson(Map<String, dynamic> json){
    rolls = List.castFrom<dynamic, String>(json['Rolls']);
    presents = List.castFrom<dynamic, String>(json['Presenties']);
    absents = List.castFrom<dynamic, String>(json['Absenties']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Rolls'] = rolls;
    _data['Presenties'] = presents;
    _data['Absenties'] = absents;
    return _data;
  }
}