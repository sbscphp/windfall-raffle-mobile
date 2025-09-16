import '../../order.dart';
import '../../order_detail.dart';

class OrderData {
  final Order? order;
  final List<OrderDetail>? orderDetails;

  OrderData({
    this.order,
    this.orderDetails,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
    "order_details": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
  };
}