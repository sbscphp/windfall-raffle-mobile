import 'package:windfall/core/data/models/user.dart';
import 'order.dart';

class Referral {
  final String? status;
  final String? reason;
  final dynamic amount;
  final DateTime? date;
  final Order? order;
  final User? referredUser;

  Referral({
    this.status,
    this.reason,
    this.amount,
    this.date,
    this.order,
    this.referredUser,
  });

  factory Referral.fromJson(Map<String, dynamic> json) => Referral(
    status: json["status"],
    reason: json["reason"],
    amount: json["amount"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    referredUser: json["referred_user"] == null ? null : User.fromJson(json["referred_user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "reason": reason,
    "amount": amount,
    "date": date?.toIso8601String(),
    "order": order?.toJson(),
    "referred_user": referredUser?.toJson(),
  };
}