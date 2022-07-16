import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanjaya/cubit/order_cubit.dart';
import 'package:sanjaya/shared/formatter.dart';
import 'package:sanjaya/shared/theme.dart';

class CustomOrderContent extends StatelessWidget {
  const CustomOrderContent({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.amount,
    required this.finalPrice,
    required this.status,
    required this.transactionId,
    this.orderId = "",
    this.foodId = "",
    this.isPost = false,
    this.date = '',
  }) : super(key: key);

  final String imageUrl;

  final String title;

  final int amount;

  final int finalPrice;

  final bool isPost;

  final String date;

  final String status;

  final String orderId;

  final String foodId;

  final String transactionId;

  @override
  Widget build(BuildContext context) {
    Widget getPost() {
      if (isPost) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(date, style: tGreyText.copyWith(fontSize: 10)),
            status == "Canceled"
                ? (Text("Cancelled", style: tRedText.copyWith(fontSize: 10)))
                : const SizedBox(),
          ],
        );
      } else {
        return Tooltip(
          message: status,
          triggerMode: TooltipTriggerMode.tap,
          child: Icon(
            Icons.info,
            color: cPrimaryColor,
          ),
        );
      }
    }

    return GestureDetector(
      onTap: () {
        if (status == "Belum_Bayar") {
          showDialog<String>(
            context: context,
            builder: (_) => AlertDialog(
              content: const Text("Are you sure you want to cancel?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, "No");
                  },
                  child: const Text("No"),
                ),
                TextButton(
                  child: const Text("Yes"),
                  onPressed: () {
                    Navigator.pop(context, "Yes");
                    context
                        .read<OrderCubit>()
                        .cancelOrder(transactionId, foodId);
                  },
                )
              ],
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 24,
        ),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: defaultBorder,
                image: DecorationImage(
                  image: NetworkImage("$mainUrl$imageUrl"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tBlackText.copyWith(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$amount item${amount > 1 ? 's' : ''} • ${formatter(finalPrice)}",
                    style: tGreyText.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            getPost(),
          ],
        ),
      ),
    );
  }
}
