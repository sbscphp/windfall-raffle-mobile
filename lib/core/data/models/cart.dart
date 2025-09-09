import 'package:windfall/core/data/models/cart_product.dart';
import 'cart_summary.dart';

class Cart {
  final List<CartProduct>? items;
  final CartSummary? summary;

  Cart({
    this.items,
    this.summary,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    items: json["items"] == null ? [] : List<CartProduct>.from(json["items"]!.map((x) => CartProduct.fromJson(x))),
    summary: json["summary"] == null ? null : CartSummary.fromJson(json["summary"]),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "summary": summary?.toJson(),
  };
}