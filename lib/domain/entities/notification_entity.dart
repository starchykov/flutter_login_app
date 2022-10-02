import 'package:json_annotation/json_annotation.dart';

part 'notification_entity.g.dart';

@JsonSerializable()
class NotificationEntity {
  final int id;
  final String title;
  final String body;
  final String type;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
  });

  factory NotificationEntity.fromJsom(Map<String, dynamic> json) => _$NotificationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationEntityToJson(this);

  @override
  String toString() {
    return 'NotificationEntity{type: $type}';
  }
}
