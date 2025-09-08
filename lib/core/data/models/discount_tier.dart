class DiscountTier {
  final dynamic min;
  final dynamic max;
  final dynamic value;

  DiscountTier({
    this.min,
    this.max,
    this.value,
  });

  factory DiscountTier.fromJson(Map<String, dynamic> json) => DiscountTier(
    min: json["min"],
    max: json["max"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "min": min,
    "max": max,
    "value": value,
  };
}