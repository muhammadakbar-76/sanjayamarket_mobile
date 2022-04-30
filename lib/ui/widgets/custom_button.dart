import 'package:flutter/material.dart';
import 'package:sanjaya/shared/theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    required this.eventFunc,
    this.margin = EdgeInsets.zero,
    this.width = double.infinity,
    this.type = 0,
  }) : super(key: key);

  final double width;

  final String title;

  final Function() eventFunc;

  final int type;

  final EdgeInsets margin;
  /* 
  type:
  0: primary,
  1: secondary,
  2: error
  */

  Color getBackgroundColor() {
    switch (type) {
      case 0:
        return cPrimaryColor;
      case 1:
        return cSecondaryColor;
      default:
        return cRedColor;
    }
  }

  TextStyle getTextStyle() {
    return type == 0
        ? tBlackText.copyWith(fontWeight: medium)
        : tWhiteText.copyWith(fontWeight: medium);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: 45,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: getBackgroundColor(),
          shape: RoundedRectangleBorder(
            borderRadius: defaultBorder,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: getTextStyle(),
          ),
        ),
        onPressed: eventFunc,
      ),
    );
  }
}
