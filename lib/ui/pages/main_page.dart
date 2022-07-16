import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanjaya/cubit/cart_cubit.dart';
import 'package:sanjaya/models/cart_model.dart';
import 'package:sanjaya/ui/pages/home_page.dart';
import 'package:sanjaya/ui/pages/order_page.dart';
import 'package:sanjaya/ui/pages/profile_page.dart';
import 'package:sanjaya/ui/widgets/custom_button.dart';
import 'package:sanjaya/ui/widgets/cutsom_button_navigation.dart';
import 'package:sanjaya/ui/widgets/ordered_item.dart';
import '../../cubit/page_cubit.dart';
import '../../shared/theme.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  Widget pages(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const OrderPage();
      case 2:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  Widget cart(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 5,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return BlocBuilder<CartCubit, List<CartModel>>(
                  builder: (context, state) {
                    List<Padding> orderedItems = state
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: OrderedItem(
                                title: e.title,
                                price: e.price,
                                amount: e.amount,
                                imageUrl: e.imageUrl,
                              ),
                            ))
                        .toList();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: cSecondaryColor2, width: 2),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Food Cart",
                                    style: tBlackText.copyWith(
                                      fontSize: 20,
                                      fontWeight: medium,
                                    ),
                                  ),
                                  Visibility(
                                    visible: state.isEmpty ? false : true,
                                    child: CustomButton(
                                      title: "Checkout",
                                      eventFunc: () {
                                        Navigator.pushNamed(
                                            context, "/checkout");
                                      },
                                      width: 100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              children: state.isEmpty
                                  ? <Widget>[
                                      SizedBox(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: Center(
                                          child: Text(
                                            "Cart is Empty!",
                                            style: tGreyText,
                                          ),
                                        ),
                                      )
                                    ]
                                  : orderedItems,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              });
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: cSecondaryColor2,
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
            bottom: 72,
            right: 14,
          ),
          child: Stack(
            children: [
              Icon(
                Icons.shopping_basket_sharp,
                color: cPrimaryColor,
                size: 37,
              ),
              Align(
                alignment: Alignment.topRight,
                child: BlocBuilder<CartCubit, List<CartModel>>(
                  builder: (context, state) {
                    return Visibility(
                      visible: state.isNotEmpty,
                      child: Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          color: cRedColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            state.length.toString(),
                            style: tWhiteText.copyWith(fontSize: 12),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: BlocBuilder<PageCubit, int>(
        builder: (context, state) {
          return Stack(
            children: [
              pages(state),
              CustomButtonNavigation(state),
              state == 0 ? cart(context) : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
