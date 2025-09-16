import 'game.dart';

class OrderDetail {
  final String? uuid;
  final String? gameId;
  final String? orderId;
  final int? quantity;
  final dynamic unitAmount;
  final dynamic totalAmount;
  final dynamic paidAmount;
  final dynamic discountAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Game? game;

  OrderDetail({
    this.uuid,
    this.gameId,
    this.orderId,
    this.quantity,
    this.unitAmount,
    this.totalAmount,
    this.paidAmount,
    this.discountAmount,
    this.createdAt,
    this.updatedAt,
    this.game,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    uuid: json["uuid"],
    gameId: json["game_id"],
    orderId: json["order_id"],
    quantity: json["quantity"],
    unitAmount: json["unit_amount"],
    totalAmount: json["total_amount"],
    paidAmount: json["paid_amount"],
    discountAmount: json["discount_amount"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    game: json["game"] == null ? null : Game.fromJson(json["game"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "game_id": gameId,
    "order_id": orderId,
    "quantity": quantity,
    "unit_amount": unitAmount,
    "total_amount": totalAmount,
    "paid_amount": paidAmount,
    "discount_amount": discountAmount,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "game": game?.toJson(),
  };
}