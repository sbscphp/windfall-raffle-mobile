import 'discount.dart';

class CartProduct {
  final String? uuid;
  final String? gameId;
  final String? instantGame;
  final String? cardImage;
  final String? gameName;
  final String? description;
  int? quantity;
  final dynamic unitPrice;
  final dynamic discountedUnitPrice;
  final dynamic discountPercentage;
  final dynamic discountAmount;
  final dynamic totalPrice;
  final Discount? discount;
  final int? maximumTicketNumberPurchase;
  final int? minimumTicketNumberPurchase;
  final int? ticketsLeft;

  CartProduct({
    this.uuid,
    this.gameId,
    this.description,
    this.cardImage,
    this.instantGame,
    this.gameName,
    this.quantity,
    this.unitPrice,
    this.discountedUnitPrice,
    this.discountPercentage,
    this.discountAmount,
    this.totalPrice,
    this.discount,
    this.maximumTicketNumberPurchase,
    this.minimumTicketNumberPurchase,
    this.ticketsLeft
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
    uuid: json["uuid"],
    instantGame: json["instant_game"],
    cardImage: json["card_image"],
    description: json["description"],
    gameId: json["game_id"],
    gameName: json["game_name"],
    quantity: json["quantity"],
    unitPrice: json["unit_price"],
    discountedUnitPrice: json["discounted_unit_price"],
    discountPercentage: json["discount_percentage"],
    discountAmount: json["discount_amount"],
    totalPrice: json["total_price"],
    ticketsLeft: json["tickets_left"],
    discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
    maximumTicketNumberPurchase: json["maximum_ticket_number_purchase"],
    minimumTicketNumberPurchase: json["minimum_ticket_number_purchase"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "card_image": cardImage,
    "description": description,
    "instant_game": instantGame,
    "game_id": gameId,
    "game_name": gameName,
    "quantity": quantity,
    "tickets_left": ticketsLeft,
    "unit_price": unitPrice,
    "discounted_unit_price": discountedUnitPrice,
    "discount_percentage": discountPercentage,
    "discount_amount": discountAmount,
    "total_price": totalPrice,
    "discount": discount?.toJson(),
    "maximum_ticket_number_purchase": maximumTicketNumberPurchase,
    "minimum_ticket_number_purchase": minimumTicketNumberPurchase,
  };
}