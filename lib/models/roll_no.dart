class RollModel {
  RollModel({
    required this.presents,
    required this.absents,
  });
  late final List<Presents> presents;
  late final List<Absents> absents;
  
  RollModel.fromJson(Map<String, dynamic> json){
    presents = List.from(json['presentees']).map((e)=>Presents.fromJson(e)).toList();
    absents = List.from(json['absentees']).map((e)=>Absents.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['presentees'] = presents.map((e)=>e.toJson()).toList();
    _data['absentees'] = absents.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Presents {
  Presents({
    required this.name,
    required this.roll,
  });
  late final String name;
  late final String roll;
  
  Presents.fromJson(Map<String, dynamic> json){
    name = json['name'];
    roll = json['roll'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['roll'] = roll;
    return _data;
  }
}

class Absents {
  Absents({
    required this.name,
    required this.roll,
  });
  late final String name;
  late final String roll;
  
  Absents.fromJson(Map<String, dynamic> json){
    name = json['name'];
    roll = json['roll'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['roll'] = roll;
    return _data;
  }
}