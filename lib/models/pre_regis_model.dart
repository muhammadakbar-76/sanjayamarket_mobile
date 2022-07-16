import 'package:equatable/equatable.dart';

class PreRegisModel extends Equatable {
  const PreRegisModel({
    required this.isEmailExist,
    required this.pre,
  });

  final bool isEmailExist;

  final String pre;

  factory PreRegisModel.fromJson(Map<String, dynamic> data) {
    return PreRegisModel(
      isEmailExist: data["isEmailExist"],
      pre: data["pre"],
    );
  }
  @override
  List<Object?> get props => [isEmailExist, pre];
}
