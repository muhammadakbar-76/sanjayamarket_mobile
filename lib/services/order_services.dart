import 'package:dio/dio.dart';
import 'package:sanjaya/models/order_model.dart';
import 'package:sanjaya/services/secure_storage_service.dart';
import 'package:sanjaya/shared/theme.dart';

class OrderServices {
  Future<String> orderFoods(Map<String, dynamic> orders) async {
    try {
      var token = await SecureStorageService().readSecureData("token");
      var response = await Dio().post(
        "$apiUrl/order",
        options: Options(headers: {'Authorization': "Bearer $token"}),
        data: orders,
      );
      return response.data;
    } on DioError {
      rethrow;
    }
  }

  Future<String> cancelOrder(String orderId, String foodId) async {
    try {
      var token = await SecureStorageService().readSecureData("token");
      var response = await Dio().put(
        "$apiUrl/order",
        options: Options(headers: {'Authorization': "Bearer $token"}),
        data: {
          "orderId": orderId,
          "foodId": foodId,
        },
      );
      return response.data;
    } on DioError {
      rethrow;
    }
  }

  Future<OrderModel> getAllOrder() async {
    try {
      var token = await SecureStorageService().readSecureData("token");
      var response = await Dio().get(
        "$apiUrl/order",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return OrderModel.fromJson(response.data);
    } on DioError {
      rethrow;
    }
  }
}
