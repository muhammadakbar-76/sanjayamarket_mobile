import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sanjaya/cubit/auth_cubit.dart';
import 'package:sanjaya/cubit/food_cubit.dart';
import 'package:sanjaya/cubit/order_cubit.dart';
import 'package:sanjaya/cubit/page_cubit.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/pages/success_sign_up.dart';
import 'package:sanjaya/ui/widgets/custom_button.dart';
import 'package:sanjaya/ui/widgets/custom_form_field.dart';
import 'package:sanjaya/ui/widgets/header.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smart_select/smart_select.dart';
import '../../shared/extension.dart';

class Address extends HookWidget {
  const Address({
    Key? key,
    this.file,
    required this.name,
    required this.email,
    required this.password,
  }) : super(key: key);

  final File? file;

  final String name;

  final String email;

  final String password;

  @override
  Widget build(BuildContext context) {
    List<S2Choice<String>> options = [
      S2Choice<String>(value: 'Kotabaru', title: 'Kotabaru'),
      S2Choice<String>(value: 'Balangan', title: 'Balangan'),
      S2Choice<String>(value: 'Banjar', title: 'Banjar'),
      S2Choice<String>(value: 'Barito Kuala', title: 'Barito Kuala'),
      S2Choice<String>(
        value: 'Hulu Sungai Selatan',
        title: 'Hulu Sungai Selatan',
      ),
      S2Choice<String>(
        value: 'Hulu Sungai Tengah',
        title: 'Hulu Sungai Tengah',
      ),
      S2Choice<String>(value: 'Hulu Sungai Utara', title: 'Hulu Sungai Utara'),
      S2Choice<String>(value: 'Tabalong', title: 'Tabalong'),
      S2Choice<String>(value: 'Tanah Bumbu', title: 'Tanah Bumbu'),
      S2Choice<String>(value: 'Tanah Laut', title: 'Tanah Laut'),
      S2Choice<String>(value: 'Tapin', title: 'Tapin'),
      S2Choice<String>(value: 'BanjarBaru', title: 'BanjarBaru'),
      S2Choice<String>(value: 'Banjarmasin', title: 'Banjarmasin'),
    ];

    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: ListView(
        children: [
          const Header(
            title: "Address",
            subTitle: "Make sure it's valid",
            back: true,
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
              vertical: 26,
            ),
            color: Colors.white,
            child: HookBuilder(
              builder: (_) {
                final cityState = useState("Kotabaru");
                final _formKey = useState(GlobalKey<FormState>());
                final phoneController = useTextEditingController();
                final addressController = useTextEditingController();
                final houseController = useTextEditingController();
                return BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      context.read<FoodCubit>().getAllFoods();
                      context.read<OrderCubit>().getAllOrder();
                      context.read<PageCubit>().setPage(0);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SuccessSignUp(),
                          ),
                          (route) => false);
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
                    return Form(
                      key: _formKey.value,
                      child: Column(
                        children: [
                          CustomFormField(
                            label: "Phone No.",
                            hint: "Type your phone number",
                            bottomMargin: 16,
                            validator: (val) {
                              if (val!.isValidPhone) return null;
                              return 'Enter valid Indonesian phone number';
                            },
                            controller: phoneController,
                          ),
                          CustomFormField(
                            label: "Address",
                            hint: "Type your address",
                            bottomMargin: 16,
                            controller: addressController,
                          ),
                          CustomFormField(
                            label: "House No.",
                            hint: "Type your house number",
                            bottomMargin: 16,
                            validator: (val) {
                              if (val!.isValidNumber) return null;
                              return 'Enter only number';
                            },
                            controller: houseController,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "City",
                                textAlign: TextAlign.start,
                                style: tBlackText.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                margin: const EdgeInsets.only(bottom: 24),
                                decoration: BoxDecoration(
                                  border: Border.all(color: cSecondaryColor),
                                  borderRadius: defaultBorder,
                                ),
                                child: SmartSelect<String>.single(
                                  title: "Select your city",
                                  modalType: S2ModalType.popupDialog,
                                  modalFilter: true,
                                  value: cityState.value,
                                  choiceItems: options,
                                  onChange: (val) {
                                    cityState.value = val.value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          state is AuthLoading
                              ? const CircularProgressIndicator()
                              : CustomButton(
                                  title: "Sign Up Now",
                                  eventFunc: () {
                                    context.read<AuthCubit>().signUp(
                                          name: name,
                                          email: email,
                                          password: password,
                                          address: addressController.text,
                                          phoneNumber: phoneController.text,
                                          city: cityState.value,
                                          houseNumber:
                                              int.parse(houseController.text),
                                          photoPath: file,
                                        );
                                  },
                                ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
