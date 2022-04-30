import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  const OrderModel({
    required this.payments,
    required this.orders,
  });

  final int payments;

  final List<dynamic> orders;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      payments: json["payments"],
      orders: json["orders"],
    );
  }

  @override
  List<Object?> get props => [payments, orders];
}
