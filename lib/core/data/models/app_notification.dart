class AppNotification {
  final String? id;
  final String? uuid;
  final String? type;
  final String? title;
  final String? message;
  final String? gameId;
  final dynamic orderId;
  dynamic readAt;
  final DateTime? createdAt;

  AppNotification({
    this.id,
    this.uuid,
    this.type,
    this.gameId,
    this.title,
    this.message,
    this.orderId,
    this.readAt,
    this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
    id: json["id"],
    uuid: json["uuid"],
    type: json["type"],
    title: json["title"],
    message: json["message"],
    gameId: json["gameId"],
    orderId: json["order_id"],
    readAt: json["read_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "type": type,
    "gameId": gameId,
    "title": title,
    "message": message,
    "order_id": orderId,
    "read_at": readAt,
    "created_at": createdAt?.toIso8601String(),
  };
}