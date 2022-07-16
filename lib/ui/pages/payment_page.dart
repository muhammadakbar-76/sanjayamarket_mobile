import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanjaya/cubit/order_cubit.dart';
import 'package:sanjaya/cubit/page_cubit.dart';
import 'package:sanjaya/models/storage_item.dart';
import 'package:sanjaya/services/secure_storage_service.dart';
import 'package:sanjaya/services/telegram_services.dart';
import 'package:sanjaya/shared/formatter.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/pages/main_page.dart';
import 'package:sanjaya/ui/widgets/custom_button.dart';
import 'package:sanjaya/utils/custom_exception.dart';

class PaymentPage extends HookWidget {
  const PaymentPage({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final int amount;

  @override
  Widget build(BuildContext context) {
    File? file;

    final image = useState(file);
    final isLoading = useState(false);

    Future<void> openCamera() async {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        image.value = File(pickedImage.path);
      }
    }

    Future<void> openGallery() async {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image.value = File(pickedImage.path);
      }
    }

    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is GetOrderSuccess) {
            final transactions = state.successGet.transactions
                .where((element) => element["food"]["status"] == "Belum_Bayar")
                .map((e) => e["orderId"]);
            final message = Set.from(transactions).join("\n");
            return SafeArea(
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
                            Center(
                              child: SizedBox(
                                width: 200,
                                child: DottedBorder(
                                  borderType: BorderType.Rect,
                                  color: cSecondaryColor,
                                  dashPattern: const [16, 11],
                                  child: Center(
                                    child: Container(
                                      height: 300,
                                      width: 200,
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: image.value != null
                                          ? GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: ((builder) =>
                                                      Container(
                                                        height: 100,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 20,
                                                            vertical: 20),
                                                        child: Column(
                                                          children: [
                                                            const Text(
                                                              'Choose Photo',
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .camera),
                                                                  onPressed:
                                                                      () {},
                                                                  tooltip:
                                                                      'Camera',
                                                                ),
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .image),
                                                                  onPressed:
                                                                      () {},
                                                                  tooltip:
                                                                      'Gallery',
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                );
                                              },
                                              child: Container(
                                                color: cSecondaryColor2,
                                                child: Image.file(
                                                  image.value!,
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      ((builder) => Container(
                                                            height: 100,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        20),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  'Choose Profile Photo',
                                                                  style: tBlackText
                                                                      .copyWith(
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    TextButton(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.camera,
                                                                            color:
                                                                                cBlackColor,
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 6),
                                                                          Text(
                                                                            "Camera",
                                                                            style:
                                                                                tBlackText.copyWith(
                                                                              fontSize: 13,
                                                                              fontWeight: medium,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        openCamera();
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            24),
                                                                    TextButton(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.image,
                                                                            color:
                                                                                cBlackColor,
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 6),
                                                                          Text(
                                                                            "Gallery",
                                                                            style:
                                                                                tBlackText.copyWith(
                                                                              fontSize: 13,
                                                                              fontWeight: medium,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        openGallery();
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                );
                                              },
                                              child: Container(
                                                color: cSecondaryColor2,
                                                child: Center(
                                                  child: Text(
                                                    "Add\nPhoto",
                                                    textAlign: TextAlign.center,
                                                    style: tGreyText.copyWith(
                                                      fontWeight: light,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Send an evidence of transfer picture like bill etc. This is required so our admin can processing your order.",
                              style: tBlackText,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Please read Privacy & Policy for more info about payments, any error that not from our mistake will not procceded, thank you and have a nice day.",
                              style: tBlackText,
                            ),
                            const SizedBox(height: 20),
                            isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : CustomButton(
                                    type: image.value == null ? 1 : 0,
                                    title: "Send",
                                    eventFunc: () async {
                                      if (image.value == null) return;
                                      try {
                                        isLoading.value = true;
                                        await TelegramServices()
                                            .sendImage(image.value, message);
                                        isLoading.value = false;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                const Text("Upload Success"),
                                            backgroundColor: cGreenColor,
                                          ),
                                        );
                                        Timer(const Duration(seconds: 3),
                                            () async {
                                          var uploadTry =
                                              await SecureStorageService()
                                                  .readSecureData("upload");
                                          if (uploadTry == null) {
                                            throw CustomException(
                                                "Something went wrong");
                                          }
                                          var storeItem = StorageItem(
                                              key: "upload",
                                              value: (int.parse(uploadTry) + 1)
                                                  .toString());
                                          await SecureStorageService()
                                              .deleteSecureData("upload");
                                          await SecureStorageService()
                                              .writeSecureData(storeItem);
                                          context.read<PageCubit>().setPage(0);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MainPage(),
                                              ),
                                              (route) => false);
                                        });
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(e.toString()),
                                            backgroundColor: cRedColor,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                            const SizedBox(height: 20),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "/privacy");
                                },
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
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
