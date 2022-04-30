import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sanjaya/services/secure_storage_service.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/widgets/custom_content.dart';

class ProfilePageContent extends HookWidget {
  const ProfilePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageState = useState(1);

    final SecureStorageService _secureStorage = SecureStorageService();

    Widget profileContent() {
      if (pageState.value == 1) {
        return Column(
          children: [
            const SizedBox(height: 17),
            CustomContent(title: "Edit Profile", eventFunc: () {}),
            CustomContent(title: "Home Address", eventFunc: () {}),
            CustomContent(title: "Security", eventFunc: () {}),
            CustomContent(title: "Payments", eventFunc: () {}),
            CustomContent(
                title: "Log Out",
                eventFunc: () {
                  showDialog<String>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text("You will need to login again"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, "Cancel");
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          child: const Text("Logout"),
                          onPressed: () async {
                            Navigator.pop(context, "Logout");
                            await _secureStorage.deleteAllStorage();
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/sign-in", (route) => false);
                          },
                        )
                      ],
                    ),
                  );
                }),
          ],
        );
      } else {
        return Column(
          children: [
            const SizedBox(height: 17),
            CustomContent(title: "Rate App", eventFunc: () {}),
            CustomContent(title: "Help Center", eventFunc: () {}),
            CustomContent(title: "Privacy & Policy", eventFunc: () {}),
            CustomContent(title: "Terms & Conditions", eventFunc: () {}),
          ],
        );
      }
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 10,
        bottom: 20,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: cSecondaryColor2),
              ),
            ),
            width: double.infinity,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    pageState.value = 1;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text(
                        "Account",
                        style: pageState.value == 1
                            ? tBlackText.copyWith(fontWeight: medium)
                            : tGreyText,
                      ),
                      Container(
                        height: 2,
                        width: 40,
                        color: pageState.value == 1
                            ? cBlackColor
                            : Colors.transparent,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                GestureDetector(
                  onTap: () {
                    pageState.value = 2;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text(
                        "FoodMarket",
                        style: pageState.value == 2
                            ? tBlackText.copyWith(fontWeight: medium)
                            : tGreyText,
                      ),
                      Container(
                        height: 2,
                        width: 40,
                        color: pageState.value == 2
                            ? cBlackColor
                            : Colors.transparent,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          profileContent(),
          const SizedBox(height: 79),
        ],
      ),
    );
  }
}
