import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sanjaya/cubit/auth_cubit.dart';
import 'package:sanjaya/cubit/food_cubit.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/widgets/custom_card_food.dart';
import 'package:sanjaya/ui/widgets/food_list_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget headerHome() {
      return Container(
        width: double.infinity,
        height: 108,
        padding: const EdgeInsets.all(24),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FoodMarket",
                    style: tBlackText.copyWith(
                      fontSize: 22,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    "Let's get some foods",
                    style: tGreyText.copyWith(fontWeight: light),
                  ),
                ],
              ),
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccess) {
                  return Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: defaultBorder,
                      image: DecorationImage(
                        image: NetworkImage("$mainUrl${state.user.photoPath}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      );
    }

    Widget topFood(List<dynamic> foods) {
      List<Widget> foodList = foods
          .map((e) => CustomCardFood(
                imageUrl: e.photoPath,
                title: e.name,
                rate: e.rate,
                id: e.id,
                ingredients: e.ingredients,
                description: e.description,
                price: e.price,
              ))
          .toList();
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 12,
          ),
          child: Row(
            children: foodList,
          ),
        ),
      );
    }

    return BlocConsumer<FoodCubit, FoodState>(
      listener: (context, state) {
        if (state is FoodFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: cRedColor,
              dismissDirection: DismissDirection.up,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is FoodSuccess) {
          return ListView(
            children: [
              headerHome(),
              topFood(state.foods),
              FoodListCategories(foods: state.foods),
              const SizedBox(height: 79),
            ],
          );
        }
        return Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: LoadingIndicator(
              indicatorType: Indicator.pacman,
              colors: [cPrimaryColor, cGreenColor, cRedColor, cGreyColor],
            ),
          ),
        );
      },
    );
  }
}
