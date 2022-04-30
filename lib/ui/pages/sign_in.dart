import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sanjaya/cubit/auth_cubit.dart';
import 'package:sanjaya/cubit/food_cubit.dart';
import 'package:sanjaya/cubit/order_cubit.dart';
import 'package:sanjaya/cubit/page_cubit.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/widgets/custom_button.dart';
import 'package:sanjaya/ui/widgets/custom_form_field.dart';
import 'package:sanjaya/ui/widgets/header.dart';
import '../../shared/extension.dart';

class SignIn extends HookWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = useState(GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
        backgroundColor: cBackgroundColor,
        body: Column(
          children: [
            const Header(
              title: "Sign In",
              subTitle: "Find your best ever meal",
            ),
            SizedBox(height: defaultMargin),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                ),
                color: Colors.white,
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      context.read<FoodCubit>().getAllFoods();
                      context.read<OrderCubit>().getAllOrder();
                      context.read<PageCubit>().setPage(0);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/main",
                        (route) => false,
                      );
                    } else if (state is AuthFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: cRedColor,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ListView(
                      children: [
                        Form(
                          key: _formKey.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomFormField(
                                label: "Email Address",
                                hint: "Type your email address",
                                bottomMargin: 16,
                                controller: emailController,
                                validator: (val) {
                                  if (!val!.isValidEmail) {
                                    return 'Enter Valid Email';
                                  }
                                  return null;
                                },
                              ),
                              CustomFormField(
                                label: "Password",
                                hint: "Type your password",
                                isObscure: true,
                                bottomMargin: 24,
                                controller: passwordController,
                              )
                            ],
                          ),
                        ),
                        state is AuthLoading
                            ? const Center(
                                child: Padding(
                                  child: CircularProgressIndicator(),
                                  padding: EdgeInsets.only(top: 10),
                                ),
                              )
                            : Column(
                                children: [
                                  CustomButton(
                                    title: "Sign In",
                                    margin: const EdgeInsets.only(bottom: 12),
                                    eventFunc: () async {
                                      if (_formKey.value.currentState!
                                          .validate()) {
                                        context.read<AuthCubit>().signIn(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                      }
                                    },
                                  ),
                                  CustomButton(
                                    title: "Create New Account",
                                    type: 1,
                                    eventFunc: () {
                                      Navigator.pushNamed(context, "/sign-up");
                                    },
                                  ),
                                ],
                              )
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }
}
