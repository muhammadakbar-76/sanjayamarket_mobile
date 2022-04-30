import 'package:flutter/material.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/pages/food_detail.dart';
import 'package:sanjaya/ui/widgets/get_star.dart';

class CustomCardFood extends StatelessWidget {
  const CustomCardFood({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.rate,
    required this.description,
    required this.ingredients,
    required this.price,
  }) : super(key: key);

  final String imageUrl;

  final String title;

  final double rate;

  final String id;

  final String description;

  final List<dynamic> ingredients;

  final int price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetail(
              id: id,
              title: title,
              imageUrl: imageUrl,
              rate: rate,
              description: description,
              ingredients: ingredients,
              price: price,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 24),
        width: 200,
        decoration: BoxDecoration(
          borderRadius: defaultBorder,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 15,
              offset: const Offset(0, 6), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 130,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: Image.network(
                  "$mainUrl$imageUrl",
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loading) {
                    if (loading == null) return child;
                    return Center(
                      child: Transform.scale(
                        scale: 0.7,
                        child: CircularProgressIndicator(
                          color: cPrimaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tBlackText.copyWith(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  GetStar(rate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
