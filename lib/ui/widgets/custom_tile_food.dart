import 'package:flutter/material.dart';
import 'package:sanjaya/shared/formatter.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/pages/food_detail.dart';
import 'package:sanjaya/ui/widgets/get_star.dart';

class CustomTileFood extends StatelessWidget {
  const CustomTileFood({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.rate,
    required this.price,
    required this.description,
    required this.id,
    required this.ingredients,
  }) : super(key: key);

  final double rate;

  final String imageUrl;

  final String title;

  final int price;

  final String id;

  final String description;

  final List<dynamic> ingredients;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FoodDetail(
              id: id,
              imageUrl: imageUrl,
              title: title,
              rate: rate,
              description: description,
              ingredients: ingredients,
              price: price,
            ),
          ),
        );
      },
      child: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.only(right: 12),
              child: ClipRRect(
                borderRadius: defaultBorder,
                child: Image.network(
                  "$mainUrl$imageUrl",
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loading) {
                    if (loading == null) return child;
                    return Center(
                      child: Transform.scale(
                        scale: 0.5,
                        child: CircularProgressIndicator(
                          color: cPrimaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tBlackText.copyWith(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    formatter(price),
                    style: tGreyText.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            GetStar(rate)
          ],
        ),
      ),
    );
  }
}
