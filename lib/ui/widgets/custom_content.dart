import 'package:flutter/material.dart';
import 'package:sanjaya/shared/theme.dart';

class CustomContent extends StatelessWidget {
  const CustomContent({
    Key? key,
    required this.title,
    required this.eventFunc,
  }) : super(key: key);

  final String title;

  final Function() eventFunc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: eventFunc,
      child: Container(
        margin: const EdgeInsets.only(bottom: 22),
        width: double.infinity,
        height: 22,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: tBlackText),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: cSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
