import 'package:flutter/material.dart';
import 'package:sanjaya/shared/theme.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: Center(
        child: Text(
          "If you accidentaly sending some money to my account, you must hire me to get your money back, EHHEHEHE.",
          style: tBlackText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
