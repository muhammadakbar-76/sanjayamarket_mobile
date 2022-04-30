import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanjaya/cubit/cart_cubit.dart';
import 'package:sanjaya/shared/formatter.dart';
import 'package:sanjaya/shared/theme.dart';

class OrderedItem extends StatelessWidget {
  const OrderedItem({
    Key? key,
    required this.title,
    required this.price,
    required this.amount,
    required this.imageUrl,
    this.isCartItem = false,
  }) : super(key: key);

  final String title;

  final int price;

  final int amount;

  final String imageUrl;

  final bool isCartItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: defaultBorder,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("$mainUrl$imageUrl"),
              ),
            ),
          ),
          const SizedBox(width: 12),
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
                  formatter(price),
                  style: tGreyText.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Delete this food from cart?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, "Cancel");
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          child: const Text("Yes"),
                          onPressed: () async {
                            context.read<CartCubit>().removeItem(title);
                            Navigator.pop(context, "Yes");
                          },
                        )
                      ],
                    ),
                  );
                },
                child: Text(
                  "DEL",
                  style: tRedText.copyWith(
                    fontWeight: bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "$amount item${amount > 1 ? 's' : ''}",
                style: tGreyText.copyWith(fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
