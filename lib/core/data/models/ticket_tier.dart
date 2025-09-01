class TicketTier {
  final String? uuid;
  final String? name;
  final int? quantity;
  final dynamic discountPercentage;
  final dynamic originalPrice;
  final dynamic discountPrice;

  TicketTier({
    this.uuid,
    this.name,
    this.quantity,
    this.discountPercentage,
    this.originalPrice,
    this.discountPrice,
  });

  factory TicketTier.fromJson(Map<String, dynamic> json) => TicketTier(
    uuid: json["uuid"],
    name: json["name"],
    quantity: json["quantity"],
    discountPercentage: json["discount_percentage"],
    originalPrice: json["original_price"],
    discountPrice: json["discount_price"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "quantity": quantity,
    "discount_percentage": discountPercentage,
    "original_price": originalPrice,
    "discount_price": discountPrice,
  };
}