class Order {
  final String? uuid;
  final String? uniqueId;
  final dynamic amount;

  Order({
    this.uuid,
    this.uniqueId,
    this.amount,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    uuid: json["uuid"],
    uniqueId: json["uniqueID"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "uniqueID": uniqueId,
    "amount": amount,
  };
}