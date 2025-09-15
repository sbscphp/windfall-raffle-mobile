class PaymentBreakdown {
  final int? totalTicketCount;
  final dynamic totalAmount;
  final dynamic discountAmount;
  final dynamic promoAmount;
  final dynamic promoCode;
  final dynamic promoCodeId;
  final dynamic referralAmountUsed;
  final dynamic currentReferralBalance;
  final dynamic netReferralAmountBalance;
  final dynamic amountToPay;
  final dynamic spendLimitAmount;
  final dynamic spendLimitRemaining;

  PaymentBreakdown({
    this.totalTicketCount,
    this.totalAmount,
    this.discountAmount,
    this.promoAmount,
    this.promoCode,
    this.promoCodeId,
    this.referralAmountUsed,
    this.currentReferralBalance,
    this.netReferralAmountBalance,
    this.amountToPay,
    this.spendLimitAmount,
    this.spendLimitRemaining,
  });

  factory PaymentBreakdown.fromJson(Map<String, dynamic> json) => PaymentBreakdown(
    totalTicketCount: json["total_ticket_count"],
    totalAmount: json["total_amount"],
    discountAmount: json["discount_amount"],
    promoAmount: json["promo_amount"],
    promoCode: json["promo_code"],
    promoCodeId: json["promo_code_id"],
    referralAmountUsed: json["referral_amount_used"],
    currentReferralBalance: json["current_referral_balance"],
    netReferralAmountBalance: json["net_referral_amount_balance"],
    amountToPay: json["amount_to_pay"],
    spendLimitAmount: json["spend_limit_amount"],
    spendLimitRemaining: json["spend_limit_remaining"],
  );

  Map<String, dynamic> toJson() => {
    "total_ticket_count": totalTicketCount,
    "total_amount": totalAmount,
    "discount_amount": discountAmount,
    "promo_amount": promoAmount,
    "promo_code": promoCode,
    "promo_code_id": promoCodeId,
    "referral_amount_used": referralAmountUsed,
    "current_referral_balance": currentReferralBalance,
    "net_referral_amount_balance": netReferralAmountBalance,
    "amount_to_pay": amountToPay,
    "spend_limit_amount": spendLimitAmount,
    "spend_limit_remaining": spendLimitRemaining,
  };
}