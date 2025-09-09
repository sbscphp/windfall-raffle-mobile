import 'package:windfall/core/data/models/cart.dart';

class CartData {
  final String? guestId;
  final String? userId;
  final Cart? cart;

  CartData({
    this.guestId,
    this.userId,
    this.cart,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
    guestId: json["guest_id"],
    userId: json["user_id"],
    cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
  );

  Map<String, dynamic> toJson() => {
    "guest_id": guestId,
    "user_id": userId,
    "cart": cart?.toJson(),
  };
}