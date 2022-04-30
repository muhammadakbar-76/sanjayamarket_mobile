import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sanjaya/models/user_model.dart';
import 'package:sanjaya/services/secure_storage_service.dart';
import 'package:sanjaya/shared/theme.dart';

import '../models/storage_item.dart';

class UserServices {
  final SecureStorageService _secureStorage = SecureStorageService();

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      var dio = Dio();
      var response = await dio.post(
        "$apiUrl/login",
        data: {
          'email': email,
          'password': password,
        },
      );

      var data = response.data['data'] as Map<String, dynamic>;

      StorageItem refreshToken = StorageItem(
          key: "refresh_token", value: data["payload"]["refresh_token"]);
      StorageItem token =
          StorageItem(key: "token", value: data["payload"]["token"]);
      StorageItem date =
          StorageItem(key: "date", value: DateTime.now().toString());

      await Future.wait([
        _secureStorage.writeSecureData(refreshToken),
        _secureStorage.writeSecureData(token),
        _secureStorage.writeSecureData(date),
      ]);

      return UserModel.fromJson(data["user"]);
    } on DioError {
      rethrow;
    }
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String address,
    required String phoneNumber,
    required String city,
    required int houseNumber,
    required File? photoPath,
  }) async {
    try {
      var formData = FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
        'address': address,
        'phoneNumber': phoneNumber,
        'city': city,
        'houseNumber': houseNumber,
        'photoPath': photoPath != null
            ? await MultipartFile.fromFile(
                photoPath.path,
                filename: photoPath.path.split('/').last,
              )
            : null,
      });
      var response = await Dio().post("$apiUrl/register", data: formData);
      var data = response.data['data'] as Map<String, dynamic>;

      StorageItem refreshToken = StorageItem(
          key: "refresh_token", value: data["payload"]["refresh_token"]);
      StorageItem token =
          StorageItem(key: "token", value: data["payload"]["token"]);
      StorageItem date =
          StorageItem(key: "date", value: DateTime.now().toString());

      await Future.wait([
        _secureStorage.writeSecureData(refreshToken),
        _secureStorage.writeSecureData(token),
        _secureStorage.writeSecureData(date),
      ]);

      return UserModel.fromJson(data["user"]);
    } on DioError {
      rethrow;
    }
  }

  Future<UserModel> refreshToken(String token) async {
    try {
      var response = await Dio().post(
        "$apiUrl/refresh",
        data: {
          "refresh_token": token,
        },
      );
      var data = response.data["data"] as Map<String, dynamic>;
      StorageItem newToken =
          StorageItem(key: "token", value: data["payload"]["token"]);
      await _secureStorage.deleteSecureData("token");
      await _secureStorage.writeSecureData(newToken);
      return UserModel.fromJson(data["user"]);
    } on DioError {
      rethrow;
    }
  }
}
