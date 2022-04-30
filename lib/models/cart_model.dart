import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  const CartModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.amount,
  });

  final String id;

  final String imageUrl;

  final String title;

  final int price;

  final int amount;

  @override
  List<Object?> get props => [id, imageUrl, title, price, amount];
}
