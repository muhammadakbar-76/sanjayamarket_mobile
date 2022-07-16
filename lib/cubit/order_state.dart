part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderSuccess extends OrderState {
  const OrderSuccess(this.success);

  final String success;

  @override
  List<Object> get props => [success];
}

class GetOrderSuccess extends OrderState {
  const GetOrderSuccess(this.successGet);

  final OrderModel successGet;

  @override
  List<Object> get props => [successGet];
}

class OrderFailed extends OrderState {
  const OrderFailed(this.error);

  final Map<String, dynamic> error;

  @override
  List<Object> get props => [error];
}

class OrderLoading extends OrderState {}
