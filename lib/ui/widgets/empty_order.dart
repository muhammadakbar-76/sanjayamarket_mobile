import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanjaya/cubit/page_cubit.dart';
import 'package:sanjaya/shared/theme.dart';

import 'custom_button.dart';

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30.67),
            height: 221.33,
            width: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/order_empty.png"),
              ),
            ),
          ),
          Text(
            "Ouch! Hungry",
            style: tBlackText.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 6),
          Text(
            "Seems like you have not\nordered any food yet",
            style: tGreyText.copyWith(fontWeight: light),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          CustomButton(
            title: "Find Foods",
            eventFunc: () {
              context.read<PageCubit>().setPage(0);
            },
            width: 200,
          ),
        ],
      ),
    );
  }
}
