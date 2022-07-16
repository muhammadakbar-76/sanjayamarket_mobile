import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanjaya/cubit/auth_cubit.dart';
import 'package:sanjaya/cubit/cart_cubit.dart';
import 'package:sanjaya/cubit/order_cubit.dart';
import 'package:sanjaya/models/cart_model.dart';
import 'package:sanjaya/models/storage_item.dart';
import 'package:sanjaya/services/secure_storage_service.dart';
import 'package:sanjaya/shared/formatter.dart';
import 'package:sanjaya/ui/widgets/custom_button.dart';
import 'package:sanjaya/ui/widgets/header.dart';
import 'package:sanjaya/ui/widgets/ordered_item.dart';
import '../../shared/theme.dart';

class Checkout extends StatelessWidget {
  const Checkout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget itemOrderedContent(String title, num value) {
      return Row(
        children: [
          Expanded(
            child: Text(title, style: tGreyText),
          ),
          Text(
            formatter(value),
            style: title == "Final Price" ? tGreenText : tBlackText,
          ),
        ],
      );
    }

    Widget deliverContent(String title, String value) {
      return Row(
        children: [
          Expanded(
            child: Text(title, style: tGreyText),
          ),
          Text(
            value,
            style: tBlackText,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }

    Widget itemOrdered() {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        color: Colors.white,
        child: BlocConsumer<CartCubit, List<CartModel>>(
          listener: (context, state) {
            if (state.isEmpty) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/main", (route) => false);
            }
          },
          builder: (context, state) {
            if (state.isNotEmpty) {
              double totalPrice =
                  state.fold(0, (sum, item) => sum + item.price * item.amount);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Item Ordered",
                    style: tBlackText,
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: state
                        .map((e) => OrderedItem(
                              title: e.title,
                              price: e.price,
                              amount: e.amount,
                              imageUrl: e.imageUrl,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Text("Detail Transaction", style: tBlackText),
                  const SizedBox(height: 8),
                  itemOrderedContent("Total Price", totalPrice),
                  const SizedBox(height: 6),
                  itemOrderedContent("Driver", 10000),
                  const SizedBox(height: 6),
                  itemOrderedContent("Tax 10%", totalPrice * 0.10),
                  const SizedBox(height: 6),
                  itemOrderedContent(
                    "Final Price",
                    (totalPrice) + (totalPrice * 0.10) + 10000,
                  )
                ],
              );
            }
            return const SizedBox();
          },
        ),
      );
    }

    Widget deliverTo() {
      return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          color: Colors.white,
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Deliver to:", style: tBlackText),
                    const SizedBox(height: 8),
                    deliverContent("Name", state.user.name),
                    const SizedBox(height: 6),
                    deliverContent("Phone No.", state.user.phoneNumber),
                    const SizedBox(height: 6),
                    deliverContent("Adress", state.user.address),
                    const SizedBox(height: 6),
                    deliverContent(
                        "House No.", state.user.houseNumber.toString()),
                    const SizedBox(height: 6),
                    deliverContent("City", state.user.city),
                  ],
                );
              }
              return const SizedBox();
            },
          ));
    }

    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            context.read<OrderCubit>().getAllOrder();
            Navigator.pushNamedAndRemoveUntil(
                context, "/success-checkout", (route) => false);
          } else if (state is OrderFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error["message"])));
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              const Header(
                title: "Payment",
                subTitle: "You deserve better meal",
                back: true,
              ),
              const SizedBox(height: 24),
              itemOrdered(),
              const SizedBox(height: 24),
              deliverTo(),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: state is OrderLoading
                      ? [
                          const SizedBox(height: 10),
                          CircularProgressIndicator(color: cPrimaryColor),
                        ]
                      : [
                          BlocBuilder<CartCubit, List<CartModel>>(
                            builder: (context, state) {
                              return CustomButton(
                                title: "Order Now",
                                eventFunc: () async {
                                  if (state.isEmpty) return;
                                  final uploadTry = await SecureStorageService()
                                      .containsKeyInStorage("upload");
                                  if (uploadTry) {
                                    var storeItem = const StorageItem(
                                        key: "upload", value: "0");
                                    await SecureStorageService()
                                        .deleteSecureData("upload");
                                    await SecureStorageService()
                                        .writeSecureData(storeItem);
                                  } else {
                                    var storeItem = const StorageItem(
                                        key: "upload", value: "0");
                                    await SecureStorageService()
                                        .writeSecureData(storeItem);
                                  }
                                  context.read<OrderCubit>().orderFoods({
                                    "food": state.map((el) => el.id).toList(),
                                    "quantity":
                                        state.map((el) => el.amount).toList(),
                                  });
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            type: 1,
                            title: "Order Another Food",
                            eventFunc: () {
                              Navigator.pushNamed(context, "/main");
                            },
                          ),
                        ],
                ),
              ),
              const SizedBox(height: 26),
            ],
          );
        },
      ),
    );
  }
}
