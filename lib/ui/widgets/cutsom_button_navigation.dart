import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanjaya/cubit/page_cubit.dart';

class CustomButtonNavigation extends StatelessWidget {
  const CustomButtonNavigation(
    this.index, {
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        height: 60,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                context.read<PageCubit>().setPage(0);
              },
              child: Image.asset(
                index == 0
                    ? "assets/images/ic_home.png"
                    : "assets/images/ic_home_normal.png",
                height: 32,
                width: 32,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<PageCubit>().setPage(1);
              },
              child: Image.asset(
                index == 1
                    ? "assets/images/ic_order.png"
                    : "assets/images/ic_order_normal.png",
                height: 32,
                width: 32,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<PageCubit>().setPage(2);
              },
              child: Image.asset(
                index == 2
                    ? "assets/images/ic_profile.png"
                    : "assets/images/ic_profile_normal.png",
                height: 32,
                width: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
