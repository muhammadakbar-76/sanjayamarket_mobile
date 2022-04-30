import 'package:bloc/bloc.dart';
import 'package:sanjaya/models/cart_model.dart';

class CartCubit extends Cubit<List<CartModel>> {
  CartCubit() : super([]);

  void addToCart(CartModel cartItem) {
    List<CartModel> cartState = List.from(state);
    if (cartState.any((element) => element.id == cartItem.id)) {
      cartState.removeWhere((element) => element.id == cartItem.id);
    }
    cartState.add(cartItem);
    emit(cartState);
  }

  void removeItem(String title) {
    List<CartModel> cartState = List.from(state);
    cartState.removeWhere((item) => item.title == title);
    emit(cartState);
  }

  void removeAll() {
    emit([]);
  }
}
