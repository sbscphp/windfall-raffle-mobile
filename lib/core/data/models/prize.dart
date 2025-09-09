import 'package:windfall/core/data/models/ticket.dart';

class Prize {
  final String? uuid;
  final String? name;
  final String? description;
  final dynamic totalQuantity;
  final dynamic availableToBeWon;
  final List<Ticket>? tickets;

  Prize({
    this.uuid,
    this.name,
    this.description,
    this.totalQuantity,
    this.availableToBeWon,
    this.tickets,
  });

  factory Prize.fromJson(Map<String, dynamic> json) => Prize(
    uuid: json["uuid"],
    name: json["name"],
    description: json["description"],
    totalQuantity: json["total_quantity"],
    availableToBeWon: json["available_to_be_won"],
    tickets: json["tickets"] == null ? [] : List<Ticket>.from(json["tickets"]!.map((x) => Ticket.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "description": description,
    "total_quantity": totalQuantity,
    "available_to_be_won": availableToBeWon,
    "tickets": tickets == null ? [] : List<dynamic>.from(tickets!.map((x) => x.toJson())),
  };
}