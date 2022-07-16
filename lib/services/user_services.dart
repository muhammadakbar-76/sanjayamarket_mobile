import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sanjaya/models/pre_regis_model.dart';
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
      StorageItem credentials = StorageItem(
          key: "credentials",
          value: json.encode({
            "token": data["payload"]["token"],
            "telegram_key": data["payload"]["telegram_key"],
            "chat_id": data["payload"]["chat_id"],
          }));
      StorageItem date =
          StorageItem(key: "date", value: DateTime.now().toString());

      await Future.wait([
        _secureStorage.writeSecureData(refreshToken),
        _secureStorage.writeSecureData(credentials),
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
    required String code,
    required String pre,
  }) async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
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
        'fcmToken': fcmToken,
      });
      var response = await Dio()
          .post("$apiUrl/register?pre=$pre&code=$code", data: formData);
      var data = response.data['data'] as Map<String, dynamic>;

      StorageItem refreshToken = StorageItem(
          key: "refresh_token", value: data["payload"]["refresh_token"]);
      StorageItem credentials = StorageItem(
          key: "credentials",
          value: json.encode({
            "token": data["payload"]["token"],
            "telegram_key": data["payload"]["telegram_key"],
            "chat_id": data["payload"]["chat_id"],
          }));
      StorageItem date =
          StorageItem(key: "date", value: DateTime.now().toString());

      await Future.wait([
        _secureStorage.writeSecureData(refreshToken),
        _secureStorage.writeSecureData(credentials),
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
      StorageItem newCredentials = StorageItem(
          key: "credentials",
          value: json.encode({
            "token": data["payload"]["token"],
            "telegram_key": data["payload"]["telegram_key"],
            "chat_id": data["payload"]["chat_id"],
          }));
      await _secureStorage.deleteSecureData("credentials");
      await _secureStorage.writeSecureData(newCredentials);
      return UserModel.fromJson(data["user"]);
    } on DioError {
      rethrow;
    }
  }

  Future<PreRegisModel> checkEmail(String email) async {
    try {
      var response = await Dio().post("$apiUrl/check-email", data: {
        "email": email,
      });

      var data = response.data as Map<String, dynamic>;
      return PreRegisModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getCode({
    required String pre,
    required String name,
    required String email,
  }) async {
    try {
      var response = await Dio().post("$apiUrl/send-code", data: {
        "pre": pre,
        "email": email,
        "name": name,
      });

      var data = response.data as Map<String, dynamic>;

      return data["pre"];
    } catch (e) {
      rethrow;
    }
  }
}
