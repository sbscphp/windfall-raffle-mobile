class Order {
  final String? uuid;
  final String? uniqueId;
  final dynamic amount;
  final String? customerId;
  final String? platform;
  final String? paymentMethod;
  final String? paymentChannel;
  final String? transactionId;
  final dynamic promoCodeId;
  final String? reference;
  final int? quantity;
  final int? gamesCount;
  final dynamic totalAmount;
  final dynamic paidAmount;
  final dynamic promoAmount;
  final dynamic discountAmount;
  final dynamic referralBalanceAmount;
  final dynamic promoCode;
  final dynamic referralCode;
  final String? status;
  final String? paymentStatus;
  final String? ipAddress;
  final String? city;
  final String? region;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? ticketsCount;


  Order({
    this.uuid,
    this.uniqueId,
    this.amount,
    this.customerId,
    this.platform,
    this.paymentMethod,
    this.paymentChannel,
    this.transactionId,
    this.promoCodeId,
    this.reference,
    this.quantity,
    this.totalAmount,
    this.paidAmount,
    this.promoAmount,
    this.discountAmount,
    this.referralBalanceAmount,
    this.promoCode,
    this.referralCode,
    this.status,
    this.paymentStatus,
    this.ipAddress,
    this.city,
    this.region,
    this.createdAt,
    this.updatedAt,
    this.ticketsCount,
    this.gamesCount

  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    uuid: json["uuid"],
    uniqueId: json["uniqueID"],
    amount: json["amount"],
    gamesCount: json["games_count"],
    customerId: json["customer_id"],
    platform: json["platform"],
    paymentMethod: json["payment_method"],
    paymentChannel: json["payment_channel"],
    transactionId: json["transaction_id"],
    promoCodeId: json["promo_code_id"],
    reference: json["reference"],
    quantity: json["quantity"],
    totalAmount: json["total_amount"],
    paidAmount: json["paid_amount"],
    promoAmount: json["promo_amount"],
    discountAmount: json["discount_amount"],
    referralBalanceAmount: json["referral_balance_amount"],
    promoCode: json["promo_code"],
    referralCode: json["referral_code"],
    status: json["status"],
    paymentStatus: json["payment_status"],
    ipAddress: json["ip_address"],
    city: json["city"],
    region: json["region"],
    ticketsCount: json["tickets_count"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "uniqueID": uniqueId,
    "amount": amount,
    "games_count": gamesCount,
    "customer_id": customerId,
    "platform": platform,
    "payment_method": paymentMethod,
    "payment_channel": paymentChannel,
    "transaction_id": transactionId,
    "promo_code_id": promoCodeId,
    "reference": reference,
    "quantity": quantity,
    "total_amount": totalAmount,
    "paid_amount": paidAmount,
    "promo_amount": promoAmount,
    "discount_amount": discountAmount,
    "referral_balance_amount": referralBalanceAmount,
    "promo_code": promoCode,
    "referral_code": referralCode,
    "status": status,
    "payment_status": paymentStatus,
    "ip_address": ipAddress,
    "city": city,
    "region": region,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "tickets_count": ticketsCount,
  };
}