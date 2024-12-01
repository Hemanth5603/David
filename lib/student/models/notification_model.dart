class NotificationModel {
  NotificationModel({
    required this.notifications,
    required this.status,
  });
  late final List<Notifications> notifications;
  late final bool status;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notifications = List.from(json['notifications'])
        .map((e) => Notifications.fromJson(e))
        .toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['notifications'] = notifications.map((e) => e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class Notifications {
  Notifications({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.notificationType,
    required this.creator,
    required this.status,
  });
  late final int id;
  late final String title;
  late final String description;
  late final String createdAt;
  late final String updatedAt;
  late final String notificationType;
  late final String creator;
  late final String status;

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notificationType = json['notification_type'];
    creator = json['creator'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['notification_type'] = notificationType;
    _data['creator'] = creator;
    _data['status'] = status;
    return _data;
  }
}
