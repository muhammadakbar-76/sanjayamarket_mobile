import 'package:equatable/equatable.dart';

class FoodModel extends Equatable {
  const FoodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.price,
    required this.rate,
    required this.types,
    required this.orderCount,
    required this.date,
    required this.photoPath,
  });

  final String id;

  final String name;

  final String description;

  final List<dynamic> ingredients;

  final int price;

  final double rate;

  final String types;

  final int orderCount;

  final String date;

  final String photoPath;

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        ingredients: json["ingredients"],
        price: json["price"],
        rate: json["rate"].toDouble(),
        types: json["types"],
        orderCount: json["orderCount"],
        date: json["date"],
        photoPath: json["picturePath"],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        ingredients,
        price,
        rate,
        types,
        orderCount,
        date,
        photoPath,
      ];
}
