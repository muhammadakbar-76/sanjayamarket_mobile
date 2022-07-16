import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sanjaya/models/food_model.dart';
import 'package:sanjaya/services/secure_storage_service.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/utils/custom_exception.dart';

class FoodServices {
  Future<List<dynamic>> getAllFoods() async {
    try {
      var credentials =
          await SecureStorageService().readSecureData("credentials");
      if (credentials != null) {
        Map token = jsonDecode(credentials);
        var response = await Dio().get("$apiUrl/foods",
            options: Options(
                headers: {'Authorization': "Bearer ${token['token']}"}));
        var listOfFoods = response.data;
        var foods = listOfFoods
            .map(
              (e) => FoodModel.fromJson(e),
            )
            .toList();
        return foods;
      }
      throw CustomException("Credentials Is Null");
    } on DioError {
      rethrow;
    }
  }
}
