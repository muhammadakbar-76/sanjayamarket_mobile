import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.city,
    required this.photoPath,
    required this.houseNumber,
  });

  final String name;
  final String email;
  final String address;
  final String phoneNumber;
  final String city;
  final String photoPath;
  final int houseNumber;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        address: json['address'],
        phoneNumber: json['phoneNumber'],
        city: json['city'],
        photoPath: json['photoPath'],
        houseNumber: json['houseNumber'],
      );

  @override
  List<Object?> get props =>
      [name, email, address, phoneNumber, city, photoPath, houseNumber];
}
