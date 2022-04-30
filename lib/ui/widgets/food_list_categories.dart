import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/widgets/custom_tile_food.dart';

class FoodListCategories extends HookWidget {
  const FoodListCategories({
    Key? key,
    required this.foods,
  }) : super(key: key);

  final List<dynamic> foods;

  @override
  Widget build(BuildContext context) {
    final foodPage = useState(1);

    List<Widget> foodList() {
      if (foodPage.value == 1) {
        foods.sort(((a, b) {
          var adate = a.date;
          var bdate = b.date;
          return -adate.compareTo(bdate);
        }));
        return foods
            .map(
              (e) => CustomTileFood(
                imageUrl: e.photoPath,
                title: e.name,
                rate: e.rate.toDouble(),
                price: e.price,
                ingredients: e.ingredients,
                description: e.description,
                id: e.id,
              ),
            )
            .toList();
      } else if (foodPage.value == 2) {
        foods.sort(((a, b) {
          var aorder = a.orderCount;
          var border = b.orderCount;
          return -aorder.compareTo(border);
        }));
        return foods
            .map(
              (e) => CustomTileFood(
                imageUrl: e.photoPath,
                title: e.name,
                rate: e.rate.toDouble(),
                price: e.price,
                ingredients: e.ingredients,
                description: e.description,
                id: e.id,
              ),
            )
            .toList();
      } else {
        foods.sort(((a, b) {
          var arate = a.rate.toDouble();
          var brate = b.rate.toDouble();
          return -arate.compareTo(brate);
        }));
        return foods
            .map(
              (e) => CustomTileFood(
                imageUrl: e.photoPath,
                title: e.name,
                rate: e.rate.toDouble(),
                price: e.price,
                ingredients: e.ingredients,
                description: e.description,
                id: e.id,
              ),
            )
            .toList();
      }
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 10,
        bottom: 20,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: cSecondaryColor2),
              ),
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    foodPage.value = 1;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text(
                        "New Taste",
                        style: foodPage.value == 1
                            ? tBlackText.copyWith(fontWeight: medium)
                            : tGreyText,
                      ),
                      Container(
                        height: 2,
                        width: 40,
                        color: foodPage.value == 1
                            ? cBlackColor
                            : Colors.transparent,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    foodPage.value = 2;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text(
                        "Popular",
                        style: foodPage.value == 2
                            ? tBlackText.copyWith(fontWeight: medium)
                            : tGreyText,
                      ),
                      Container(
                        height: 2,
                        width: 40,
                        color: foodPage.value == 2
                            ? cBlackColor
                            : Colors.transparent,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    foodPage.value = 3;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text(
                        "Recommended",
                        style: foodPage.value == 3
                            ? tBlackText.copyWith(fontWeight: medium)
                            : tGreyText,
                      ),
                      Container(
                        height: 2,
                        width: 40,
                        color: foodPage.value == 3
                            ? cBlackColor
                            : Colors.transparent,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Column(
            children: foodList(),
          )
        ],
      ),
    );
  }
}
