import 'package:dio/dio.dart';
import 'package:sanjaya/models/food_model.dart';
import 'package:sanjaya/services/secure_storage_service.dart';
import 'package:sanjaya/shared/theme.dart';

class FoodServices {
  Future<List<dynamic>> getAllFoods() async {
    try {
      var token = await SecureStorageService().readSecureData("token");
      var response = await Dio().get("$apiUrl/foods",
          options: Options(headers: {'Authorization': "Bearer $token"}));
      var listOfFoods = response.data;
      var foods = listOfFoods
          .map(
            (e) => FoodModel.fromJson(e),
          )
          .toList();
      return foods;
    } on DioError {
      rethrow;
    }
  }
}
