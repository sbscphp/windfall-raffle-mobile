class CartSummary {
  final int? totalQuantity;
  final dynamic totalAmount;
  final dynamic totalDiscountedAmount;
  final dynamic overallDiscountPercentage;

  CartSummary({
    this.totalQuantity,
    this.totalAmount,
    this.totalDiscountedAmount,
    this.overallDiscountPercentage,
  });

  factory CartSummary.fromJson(Map<String, dynamic> json) => CartSummary(
    totalQuantity: json["total_quantity"],
    totalAmount: json["total_amount"],
    totalDiscountedAmount: json["total_discounted_amount"],
    overallDiscountPercentage: json["overall_discount_percentage"],
  );

  Map<String, dynamic> toJson() => {
    "total_quantity": totalQuantity,
    "total_amount": totalAmount,
    "total_discounted_amount": totalDiscountedAmount,
    "overall_discount_percentage": overallDiscountPercentage,
  };
}