import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sanjaya/models/order_model.dart';
import 'package:sanjaya/services/order_services.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  void orderFoods(Map<String, dynamic> orders) async {
    try {
      emit(OrderLoading());
      var success = await OrderServices().orderFoods(orders);
      emit(OrderSuccess(success));
    } on DioError catch (e) {
      if (e.response != null) {
        emit(OrderFailed(e.response!.data["message"]));
      } else {
        emit(OrderFailed(e.message));
      }
    }
  }

  void getAllOrder() async {
    try {
      emit(OrderLoading());
      var successGet = await OrderServices().getAllOrder();
      emit(GetOrderSuccess(successGet));
    } on DioError catch (e) {
      if (e.response != null) {
        emit(OrderFailed(e.response!.data["message"]));
      } else {
        emit(OrderFailed(e.message));
      }
    }
  }

  void cancelOrder(String orderId, String foodId) async {
    try {
      emit(OrderLoading());
      var cancelOrder = await OrderServices().cancelOrder(orderId, foodId);
      emit(OrderSuccess(cancelOrder));
    } on DioError catch (e) {
      if (e.response != null) {
        emit(OrderFailed(e.response!.data["message"]));
      } else {
        emit(OrderFailed(e.message));
      }
    }
  }
}
