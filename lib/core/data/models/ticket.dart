import 'package:windfall/core/data/models/prize.dart';

class Ticket {
  final String? uuid;
  final String? ticketNumber;
  final dynamic issuedAt;
  final String? flag;
  final String? status;
  final Prize? prize;
  final bool? ownedByUser;

  Ticket({
    this.uuid,
    this.ticketNumber,
    this.issuedAt,
    this.flag,
    this.prize,
    this.ownedByUser,
    this.status
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    uuid: json["uuid"],
    status: json["status"],
    ticketNumber: json["ticket_number"],
    issuedAt: json["issued_at"],
    flag: json["flag"],
    prize: json["prize"] == null ? null : Prize.fromJson(json["prize"]),
    ownedByUser: json["owned_by_user"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "status": status,
    "ticket_number": ticketNumber,
    "issued_at": issuedAt,
    "flag": flag,
    "prize": prize?.toJson(),
    "owned_by_user": ownedByUser,
  };
}