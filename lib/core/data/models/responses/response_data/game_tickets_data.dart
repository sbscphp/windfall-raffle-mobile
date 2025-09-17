import 'package:windfall/core/data/models/responses/response_data/pagination_data.dart';
import 'package:windfall/core/data/models/ticket.dart';

import '../../game.dart';

class GameTicketsData {
  final Game? game;
  final PaginationData<Ticket>? tickets;

  GameTicketsData({
    this.game,
    this.tickets,
  });

  factory GameTicketsData.fromJson(Map<String, dynamic> json) => GameTicketsData(
    game: json["game"] == null ? null : Game.fromJson(json["game"]),
    tickets: json['transactions'] != null
        ? PaginationData<Ticket>.fromJson(
      json['transactions'],
          (e) => Ticket.fromJson(e),
    )
        : null,
  );

  Map<String, dynamic> toJson() => {
    "game": game?.toJson(),
    'tickets': tickets?.toJson(
          (e) => e.toJson(),
    ),
  };
}