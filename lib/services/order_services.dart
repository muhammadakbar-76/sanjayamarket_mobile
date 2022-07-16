import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sanjaya/models/order_model.dart';
import 'package:sanjaya/services/secure_storage_service.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/utils/custom_exception.dart';

class OrderServices {
  Future<String> orderFoods(Map<String, dynamic> orders) async {
    try {
      var credentials =
          await SecureStorageService().readSecureData("credentials");
      if (credentials != null) {
        Map token = jsonDecode(credentials);
        var response = await Dio().post(
          "$apiUrl/transaction",
          options:
              Options(headers: {'Authorization': "Bearer ${token['token']}"}),
          data: orders,
        );
        return response.data;
      }
      throw CustomException("Credentials Is Null");
    } on DioError {
      rethrow;
    }
  }

  Future<String> cancelTransaction(String transactionId, String foodId) async {
    try {
      var credentials =
          await SecureStorageService().readSecureData("credentials");
      if (credentials != null) {
        Map token = jsonDecode(credentials);
        var response = await Dio().put(
          "$apiUrl/transaction",
          options:
              Options(headers: {'Authorization': "Bearer ${token['token']}"}),
          data: {
            "transactionId": transactionId,
            "foodId": foodId,
          },
        );
        return response.data;
      }
      throw CustomException("Credentials Is Null");
    } on DioError {
      rethrow;
    }
  }

  Future<OrderModel> getAllTransactions() async {
    try {
      var credentials =
          await SecureStorageService().readSecureData("credentials");
      if (credentials != null) {
        Map token = jsonDecode(credentials);
        var response = await Dio().get(
          "$apiUrl/transactions",
          options:
              Options(headers: {"Authorization": "Bearer ${token['token']}"}),
        );
        return OrderModel.fromJson(response.data);
      }
      throw CustomException("Credentials Is Null");
    } on DioError {
      rethrow;
    }
  }
}
