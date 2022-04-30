import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sanjaya/models/user_model.dart';
import 'package:sanjaya/services/user_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user =
          await UserServices().signIn(email: email, password: password);
      emit(AuthSuccess(user));
    } on DioError catch (e) {
      if (e.response != null) {
        emit(AuthFailed(e.response!.data["message"]));
      } else {
        emit(AuthFailed(e.message));
      }
    }
  }

  void refreshToken(String token) async {
    try {
      emit(AuthLoading());
      UserModel user = await UserServices().refreshToken(token);
      emit(AuthSuccess(user));
    } on DioError catch (e) {
      if (e.response != null) {
        emit(AuthFailed(e.response!.data["message"]));
      } else {
        emit(AuthFailed(e.message));
      }
    }
  }

  void signUp({
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
      emit(AuthLoading());
      UserModel user = await UserServices().register(
          name: name,
          email: email,
          password: password,
          address: address,
          phoneNumber: phoneNumber,
          city: city,
          houseNumber: houseNumber,
          photoPath: photoPath);
      emit(AuthSuccess(user));
    } on DioError catch (e) {
      if (e.response != null) {
        emit(AuthFailed(e.response!.data["message"]));
      } else {
        emit(AuthFailed(e.message));
      }
    }
  }
}
