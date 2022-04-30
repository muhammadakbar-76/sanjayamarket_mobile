part of 'food_cubit.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {}

class FoodSuccess extends FoodState {
  const FoodSuccess(this.foods);

  final List<dynamic> foods;

  @override
  List<Object> get props => [foods];
}

class FoodLoading extends FoodState {}

class FoodFailed extends FoodState {
  const FoodFailed(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
