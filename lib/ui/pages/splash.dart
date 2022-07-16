import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sanjaya/cubit/auth_cubit.dart';
import 'package:sanjaya/cubit/food_cubit.dart';
import 'package:sanjaya/cubit/order_cubit.dart';
import 'package:sanjaya/models/storage_item.dart';
import 'package:sanjaya/services/secure_storage_service.dart';
import 'package:sanjaya/shared/theme.dart';

class SplashPage extends HookWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);

    useEffect(() {
      Timer(
        const Duration(seconds: 3),
        () async {
          try {
            var connection = await InternetAddress.lookup("www.google.com");
            if (connection.isNotEmpty) {
              loading.value = true;
              var isContainKey = await Future.wait([
                SecureStorageService().containsKeyInStorage("refresh_token"),
                SecureStorageService().containsKeyInStorage("upload"),
              ]);
              if (!isContainKey[1]) {
                await SecureStorageService().writeSecureData(
                    const StorageItem(key: "upload", value: "0"));
              }
              if (!isContainKey[0]) {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/sign-in", (route) => false);
              } else {
                var data = await Future.wait([
                  SecureStorageService().readSecureData("date"),
                  SecureStorageService().readSecureData("refresh_token"),
                ]);
                var dateNow = DateTime.now();
                if (data[1] != null &&
                    dateNow.difference(DateTime.parse(data[0]!)).inDays <= 29) {
                  context.read<AuthCubit>().refreshToken(data[1]!);
                } else {
                  await SecureStorageService().deleteAllStorage();
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/sign-in", (route) => false);
                }
              }
            }
          } on SocketException {
            Fluttertoast.showToast(
              msg: "Can't Access to Internet",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
              textColor: cBlackColor,
            );
          }
        },
      );
      return null;
    }, []);
    return Scaffold(
      backgroundColor: cPrimaryColor,
      body: Center(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.read<FoodCubit>().getAllFoods();
              context.read<OrderCubit>().getAllOrder();
              Navigator.pushNamedAndRemoveUntil(
                context,
                "/main",
                (route) => false,
              );
            } else if (state is AuthFailed) {
              loading.value = false;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: cRedColor,
                ),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 84.38,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/icon_home.png"),
                  ),
                ),
              ),
              const SizedBox(height: 37.81),
              loading.value
                  ? SizedBox(
                      width: 80,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulseSync,
                        colors: [cBlackColor, Colors.white],
                        strokeWidth: 0.5,
                      ),
                    )
                  : Text(
                      "Sanjaya",
                      style: tBlackText.copyWith(
                        fontSize: 32,
                        fontWeight: medium,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
