import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:sanjaya/cubit/auth_cubit.dart';
import 'package:sanjaya/services/user_services.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/widgets/custom_button.dart';
import 'package:sanjaya/ui/widgets/header.dart';

class ConfirmEmail extends HookWidget {
  const ConfirmEmail({
    Key? key,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber,
    required this.city,
    required this.houseNumber,
    required this.file,
    required this.pre,
  }) : super(key: key);

  final String pre;

  final String name;

  final String email;

  final String password;

  final String address;

  final String phoneNumber;

  final String city;

  final int houseNumber;

  final File? file;

  @override
  Widget build(BuildContext context) {
    final isSending = useState(false);
    final prex = useState('');

    useEffect(() {
      isSending.value = true;
      () async {
        try {
          prex.value =
              await UserServices().getCode(pre: pre, name: name, email: email);
        } catch (e) {
          if (e is DioError) {
            if (e.response != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.response!.data["message"]),
                  backgroundColor: cRedColor,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message),
                  backgroundColor: cRedColor,
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
                backgroundColor: cRedColor,
              ),
            );
          }
        }
      }();
      return;
    }, []);

    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            const Header(
              title: "Verification",
              subTitle: "Verify your Email",
              back: true,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: ClipOval(
                  child: Container(
                    color: cSecondaryColor2.withOpacity(0.5),
                    padding: const EdgeInsets.all(18),
                    child: Container(
                      height: 95,
                      width: 95,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cPrimaryColor,
                      ),
                      child: const Icon(
                        Icons.admin_panel_settings_sharp,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            HookBuilder(
              builder: (context) {
                final code = useState("");
                final isEditing = useState(false);

                Widget countDown() {
                  return HookBuilder(
                    builder: ((context) {
                      final _timer =
                          useState(Timer(const Duration(seconds: 0), () {}));
                      final _countDown = useState(60);

                      useEffect(() {
                        _timer.value = Timer.periodic(
                          const Duration(seconds: 1),
                          (timer) {
                            if (_countDown.value == 0) {
                              timer.cancel();
                              isSending.value = false;
                            } else {
                              _countDown.value--;
                            }
                          },
                        );
                        return () => _timer.value.cancel();
                      }, []);

                      return Container(
                        width: 300,
                        height: 45,
                        decoration: BoxDecoration(
                            color: cSecondaryColor,
                            borderRadius: defaultBorder),
                        child: Center(
                          child: Text(
                            _countDown.value.toString(),
                            style: tWhiteText.copyWith(
                              fontWeight: medium,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }

                return Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        "Verification Code",
                        style: tBlackText.copyWith(
                          fontSize: 20,
                          fontWeight: medium,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Please check your email and\ninput the code",
                        style: tGreyText,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Center(
                          child: VerificationCode(
                            textStyle: tBlackText,
                            keyboardType: TextInputType.number,
                            underlineColor: cGreenColor,
                            length: 6,
                            onCompleted: (String value) {
                              code.value = value;
                            },
                            onEditing: (bool isEdit) {
                              isEditing.value = isEdit;
                              if (!isEditing.value) {
                                FocusScope.of(context).unfocus();
                              }
                            },
                          ),
                        ),
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthFailed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error),
                              ),
                            );
                          } else if (state is AuthSuccess) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/main", (route) => false);
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return Column(
                              children: const [
                                CircularProgressIndicator(),
                                SizedBox(height: 20),
                              ],
                            );
                          }
                          return Column(
                            children: [
                              CustomButton(
                                title: "Verify",
                                eventFunc: () {
                                  context.read<AuthCubit>().signUp(
                                        name: name,
                                        email: email,
                                        password: password,
                                        address: address,
                                        phoneNumber: phoneNumber,
                                        city: city,
                                        houseNumber: houseNumber,
                                        photoPath: file,
                                        code: code.value,
                                        pre: prex.value,
                                      );
                                },
                                width: 300,
                              ),
                              const SizedBox(height: 6),
                              isSending.value
                                  ? countDown()
                                  : CustomButton(
                                      title: "Send Again",
                                      eventFunc: () async {
                                        isSending.value = true;
                                        prex.value =
                                            await UserServices().getCode(
                                          pre: prex.value,
                                          name: name,
                                          email: email,
                                        );
                                      },
                                      type: 1,
                                      width: 300,
                                    ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
