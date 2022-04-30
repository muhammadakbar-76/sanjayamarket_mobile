import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sanjaya/cubit/order_cubit.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/widgets/empty_order.dart';
import 'package:sanjaya/ui/widgets/order_exists.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: cRedColor,
            ),
          );
        } else if (state is OrderSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.success),
              backgroundColor: cGreenColor,
            ),
          );
          Timer(const Duration(seconds: 2), () {
            context.read<OrderCubit>().getAllOrder();
          });
        }
      },
      builder: (context, state) {
        if (state is GetOrderSuccess) {
          if (state.successGet.orders.isNotEmpty) {
            return OrderExist(state.successGet);
          } else {
            return const EmptyOrder();
          }
        }
        return Center(
          child: SizedBox(
            width: 70,
            height: 70,
            child: LoadingIndicator(
              indicatorType: Indicator.lineScale,
              colors: [cPrimaryColor, cGreenColor, cRedColor, cGreyColor],
            ),
          ),
        );
      },
    );
  }
}
