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
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          emit(OrderFailed({
            "message": e.response!.data["message"],
            "statusCode": e.response!.statusCode,
          }));
        } else {
          emit(OrderFailed({
            "message": e.message,
            "statusCode": 500,
          }));
        }
      } else {
        emit(OrderFailed({
          "message": e.toString(),
          "statusCode": 500,
        }));
      }
    }
  }

  void getAllOrder() async {
    try {
      emit(OrderLoading());
      var successGet = await OrderServices().getAllTransactions();
      emit(GetOrderSuccess(successGet));
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          emit(OrderFailed({
            "message": e.response!.data["message"],
            "statusCode": e.response!.statusCode,
          }));
        } else {
          emit(OrderFailed({
            "message": e.message,
            "statusCode": 500,
          }));
        }
      } else {
        emit(OrderFailed({
          "message": e.toString(),
          "statusCode": 500,
        }));
      }
    }
  }

  void cancelOrder(String transactionId, String foodId) async {
    try {
      emit(OrderLoading());
      var cancelOrder =
          await OrderServices().cancelTransaction(transactionId, foodId);
      emit(OrderSuccess(cancelOrder));
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          emit(OrderFailed({
            "message": e.response!.data["message"],
            "statusCode": e.response!.statusCode,
          }));
        } else {
          emit(OrderFailed({
            "message": e.message,
            "statusCode": 500,
          }));
        }
      } else {
        emit(OrderFailed({
          "message": e.toString(),
          "statusCode": 500,
        }));
      }
    }
  }

  OrderState? getTransactions() {
    if (state is GetOrderSuccess) return state;
    return null;
  }
}
