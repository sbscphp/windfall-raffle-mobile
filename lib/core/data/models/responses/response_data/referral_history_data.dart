import 'package:windfall/core/data/models/referral.dart';
import 'package:windfall/core/data/models/responses/response_data/pagination_data.dart';

class ReferralHistoryData {
  final dynamic totalBalance;
  final dynamic totalReceived;
  final dynamic totalSpent;
  final PaginationData<Referral>? transactions;

  ReferralHistoryData({
    this.totalBalance,
    this.totalReceived,
    this.totalSpent,
    this.transactions,
  });

  factory ReferralHistoryData.fromJson(Map<String, dynamic> json) => ReferralHistoryData(
    totalBalance: json["total_balance"],
    totalReceived: json["total_received"],
    totalSpent: json["total_spent"],
    transactions: json['transactions'] != null
        ? PaginationData<Referral>.fromJson(
      json['transactions'],
          (e) => Referral.fromJson(e),
    )
        : null,
  );

  Map<String, dynamic> toJson() => {
    "total_balance": totalBalance,
    "total_received": totalReceived,
    "total_spent": totalSpent,
    'transactions': transactions?.toJson(
          (e) => e.toJson(),
    ),
  };
}