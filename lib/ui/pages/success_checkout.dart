import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanjaya/cubit/cart_cubit.dart';
import 'package:sanjaya/cubit/page_cubit.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/widgets/custom_button.dart';

class SuccessCheckout extends StatelessWidget {
  const SuccessCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/success_checkout.png",
              height: 176.38,
              width: 200,
            ),
            const SizedBox(height: 30),
            Text(
              "You've Made Order",
              style: tBlackText.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 6),
            Text(
              "Just stay at home while we are\npreparing your best foods",
              style: tGreyText.copyWith(fontWeight: light),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomButton(
              title: "Order Other Foods",
              eventFunc: () {
                context.read<PageCubit>().setPage(0);
                context.read<CartCubit>().removeAll();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/main", (route) => false);
              },
              width: 200,
            ),
            const SizedBox(height: 12),
            CustomButton(
              title: "View My Order",
              eventFunc: () {
                context.read<PageCubit>().setPage(1);
                context.read<CartCubit>().removeAll();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/main", (route) => false);
              },
              width: 200,
              type: 1,
            ),
          ],
        ),
      ),
    );
  }
}
