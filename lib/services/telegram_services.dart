import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sanjaya/services/secure_storage_service.dart';

import '../utils/custom_exception.dart';

class TelegramServices {
  Future<dynamic> sendImage(File? file, String message) async {
    try {
      if (file == null) throw CustomException("File Is Null");
      var credentials =
          await SecureStorageService().readSecureData("credentials");
      if (credentials == null) throw CustomException("Credentials Is Null");
      Map token = jsonDecode(credentials);
      var formData = FormData.fromMap({
        "chat_id": token["chat_id"],
        "photo": await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
        "caption": message,
      });
      return Dio().post(
        "https://api.telegram.org/bot${token['telegram_key']}/sendPhoto",
        data: formData,
      );
    } catch (e) {
      rethrow;
    }
  }
}
