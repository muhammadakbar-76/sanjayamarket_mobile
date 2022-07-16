import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanjaya/cubit/auth_cubit.dart';
import 'package:sanjaya/cubit/cart_cubit.dart';
import 'package:sanjaya/cubit/food_cubit.dart';
import 'package:sanjaya/cubit/order_cubit.dart';
import 'package:sanjaya/cubit/page_cubit.dart';
import 'package:sanjaya/ui/pages/checkout.dart';
import 'package:sanjaya/ui/pages/main_page.dart';
import 'package:sanjaya/ui/pages/privacy_policy_page.dart';
import 'package:sanjaya/ui/pages/sign_in.dart';
import 'package:sanjaya/ui/pages/sign_up.dart';
import 'package:sanjaya/ui/pages/splash.dart';
import 'package:sanjaya/ui/pages/success_checkout.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => FoodCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (context) => OrderCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const SplashPage(),
          "/sign-in": (context) => const SignIn(),
          "/sign-up": (context) => const SignUp(),
          "/success-checkout": (context) => const SuccessCheckout(),
          "/checkout": (context) => const Checkout(),
          "/main": (context) => const MainPage(),
          "/privacy": (content) => const PrivacyPolicyPage(),
        },
      ),
    );
  }
}
