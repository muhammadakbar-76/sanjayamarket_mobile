import 'package:flutter/material.dart';
import 'package:sanjaya/shared/theme.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.title,
    required this.subTitle,
    this.back = false,
  }) : super(key: key);

  final String title;

  final String subTitle;

  final bool back;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 30,
          left: 24,
          bottom: 24,
        ),
        color: Colors.white,
        child: Row(
          children: [
            (back
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  )
                : const SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: tBlackText.copyWith(
                    fontSize: 22,
                    fontWeight: medium,
                  ),
                ),
                Text(
                  subTitle,
                  style: tGreyText.copyWith(
                    fontWeight: light,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
