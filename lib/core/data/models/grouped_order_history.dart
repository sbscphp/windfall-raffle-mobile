import 'package:windfall/core/data/models/order.dart';

class GroupedOrderHistory{

  final DateTime date;
  final List<Order> orderHistories;

  GroupedOrderHistory({required this.date, required this.orderHistories});
}