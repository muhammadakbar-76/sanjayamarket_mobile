import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sanjaya/services/food_services.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit() : super(FoodInitial());

  void getAllFoods() async {
    try {
      emit(FoodLoading());
      List<dynamic> foods = await FoodServices().getAllFoods();
      emit(FoodSuccess(foods));
    } catch (e) {
      if (e is DioError) {
        if (e.response == null) emit(FoodFailed(e.message));
        emit(FoodFailed(e.response!.data["message"]));
      } else {
        emit(FoodFailed(e.toString()));
      }
    }
  }
}
