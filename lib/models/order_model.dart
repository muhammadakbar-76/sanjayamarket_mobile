import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  const OrderModel({
    required this.payments,
    required this.transactions,
  });

  final int payments;

  final List<dynamic> transactions;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      payments: json["payments"],
      transactions: json["transactions"],
    );
  }

  @override
  List<Object?> get props => [payments, transactions];
}
