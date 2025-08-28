class NotificationSetting {
  final String? uuid;
  final String? userId;
  final String? pushNotification;
  final String? emailNotification;
  final String? gameDraw;
  final String? gameResultWinners;
  final String? gameSuggestions;
  final String? newGames;
  final String? paymentTransactions;
  final String? promotional;
  final String? accountSecurity;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationSetting({
    this.uuid,
    this.userId,
    this.pushNotification,
    this.emailNotification,
    this.gameDraw,
    this.gameResultWinners,
    this.gameSuggestions,
    this.newGames,
    this.paymentTransactions,
    this.promotional,
    this.accountSecurity,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationSetting.fromJson(Map<String, dynamic> json) => NotificationSetting(
    uuid: json["uuid"],
    userId: json["user_id"],
    pushNotification: json["push_notification"],
    emailNotification: json["email_notification"],
    gameDraw: json["game_draw"],
    gameResultWinners: json["game_result_winners"],
    gameSuggestions: json["game_suggestions"],
    newGames: json["new_games"],
    paymentTransactions: json["payment_transactions"],
    promotional: json["promotional"],
    accountSecurity: json["account_security"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "user_id": userId,
    "push_notification": pushNotification,
    "email_notification": emailNotification,
    "game_draw": gameDraw,
    "game_result_winners": gameResultWinners,
    "game_suggestions": gameSuggestions,
    "new_games": newGames,
    "payment_transactions": paymentTransactions,
    "promotional": promotional,
    "account_security": accountSecurity,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
