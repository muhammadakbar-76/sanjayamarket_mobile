import 'package:flutter/material.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/widgets/custom_button.dart';

class SuccessSignUp extends StatelessWidget {
  const SuccessSignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/success_sign_up.png",
              height: 289.67,
              width: 200,
            ),
            const SizedBox(height: 30),
            Text(
              "Yeay! Completed",
              style: tBlackText.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Now you are able to order\nsome foods as a self-reward",
              style: tGreyText.copyWith(fontWeight: light),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomButton(
              title: "FindFoods",
              eventFunc: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/main",
                  (route) => false,
                );
              },
              width: 200,
            )
          ],
        ),
      ),
    );
  }
}
