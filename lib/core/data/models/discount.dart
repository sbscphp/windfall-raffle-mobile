import 'package:windfall/core/data/models/discount_tier.dart';

class Discount {
  final String? type;
  final dynamic value;
  final List<DiscountTier>? tiers;

  Discount({
    this.type,
    this.value,
    this.tiers,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    type: json["type"],
    value: json["value"],
    tiers: json["tiers"] == null ? [] : List<DiscountTier>.from(json["tiers"]!.map((x) => DiscountTier.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
    "tiers": tiers == null ? [] : List<dynamic>.from(tiers!.map((x) => x.toJson())),
  };
}