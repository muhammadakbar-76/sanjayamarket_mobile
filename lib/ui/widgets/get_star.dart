import "package:flutter/material.dart";
import 'package:sanjaya/shared/theme.dart';

class GetStar extends StatelessWidget {
  const GetStar(this.rate, {Key? key}) : super(key: key);

  final double rate;

  @override
  Widget build(BuildContext context) {
    List<Widget> getStar(double rate) {
      List<Widget> stars = [];
      for (var i = 1; i < 6; i++) {
        stars.add(
          Row(
            children: [
              Image.asset(
                "assets/images/star.png",
                height: 16,
                width: 16,
                color: rate.floor() >= i ? cPrimaryColor : null,
              ),
              const SizedBox(width: 2),
            ],
          ),
        );
      }
      stars.addAll([
        const SizedBox(width: 2),
        Text(
          rate.toString(),
          style: tGreyText.copyWith(
            fontSize: 12,
          ),
        ),
      ]);

      return stars;
    }

    return Row(
      children: getStar(rate),
    );
  }
}
