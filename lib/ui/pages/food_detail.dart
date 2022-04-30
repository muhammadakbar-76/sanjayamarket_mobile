import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sanjaya/cubit/cart_cubit.dart';
import 'package:sanjaya/models/cart_model.dart';
import 'package:sanjaya/shared/formatter.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/pages/checkout.dart';
import 'package:sanjaya/ui/pages/main_page.dart';
import 'package:sanjaya/ui/widgets/custom_button.dart';
import 'package:sanjaya/ui/widgets/get_star.dart';

class FoodDetail extends HookWidget {
  const FoodDetail({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.rate,
    required this.description,
    required this.ingredients,
    required this.price,
  }) : super(key: key);

  final String id;

  final String imageUrl;

  final String title;

  final double rate;

  final String description;

  final List<dynamic> ingredients;

  final int price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("$mainUrl$imageUrl"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: IconButton(
                iconSize: 20,
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MainPage(),
                    ),
                    (route) => false,
                  );
                },
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 10,
                bottom: 27,
              ),
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(26),
                ),
              ),
              child: HookBuilder(
                builder: (context) {
                  final foodAmount = useState(1);
                  return ListView(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: tBlackText.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                GetStar(rate),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (foodAmount.value > 1) {
                                    foodAmount.value--;
                                  }
                                },
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    borderRadius: defaultBorder,
                                    border: Border.all(),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "-",
                                      style: tBlackText.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                foodAmount.value.toString(),
                                style: tBlackText.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  foodAmount.value++;
                                },
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    borderRadius: defaultBorder,
                                    border: Border.all(),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "+",
                                      style: tBlackText.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        description,
                        style: tGreyText,
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ingredients", style: tBlackText),
                          const SizedBox(height: 4),
                          Text(
                            ingredients.join(', '),
                            style: tGreyText,
                          ),
                        ],
                      ),
                      const SizedBox(height: 41),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Price :",
                                  style: tGreyText.copyWith(fontSize: 13),
                                ),
                                Text(
                                  formatter(price),
                                  style: tBlackText.copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                            title: "Add to Cart",
                            eventFunc: () {
                              context.read<CartCubit>().addToCart(CartModel(
                                    id: id,
                                    imageUrl: imageUrl,
                                    title: title,
                                    price: price,
                                    amount: foodAmount.value,
                                  ));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Checkout(),
                                ),
                              );
                            },
                            width: 163,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
