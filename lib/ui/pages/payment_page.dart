import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanjaya/cubit/page_cubit.dart';
import 'package:sanjaya/shared/formatter.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/pages/main_page.dart';
import 'package:sanjaya/ui/widgets/custom_button.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final int amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              color: cGreenColor,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment",
                    style: tWhiteText.copyWith(
                      fontSize: 20,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          "You'll need to pay :",
                          style: tWhiteText.copyWith(
                            fontSize: 20,
                            fontWeight: medium,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          formatter(amount),
                          style: tWhiteText.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Your orders will be processed\nafter the payment",
                          style: tWhiteText.copyWith(
                            fontSize: 18,
                            fontWeight: medium,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Instructions",
                        style: tBlackText.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "We receive payment via transfer only from this payment methods :",
                        style: tBlackText,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/dana.png",
                            height: 40,
                            width: 80,
                          ),
                          Text("+6282251857550", style: tBlackText),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 5),
                          Image.asset(
                            "assets/images/bni.png",
                            height: 20,
                            width: 60,
                          ),
                          const SizedBox(width: 14),
                          Text("0568643377", style: tBlackText),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Please read Privacy & Policy for more info about payments, any error that not from our mistake will not procceded, thank you and have a nice day.",
                        style: tBlackText,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        title: "Ok",
                        eventFunc: () {
                          context.read<PageCubit>().setPage(1);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainPage(),
                              ),
                              (route) => false);
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Privacy & Policy",
                            style: tGreyText.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
