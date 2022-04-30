import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sanjaya/models/order_model.dart';
import 'package:sanjaya/shared/theme.dart';
import 'package:sanjaya/ui/pages/payment_page.dart';
import 'package:sanjaya/ui/widgets/custom_order_content.dart';
import 'package:sanjaya/ui/widgets/header.dart';

class OrderExist extends HookWidget {
  const OrderExist(
    this.allOrder, {
    Key? key,
  }) : super(key: key);

  final OrderModel allOrder;

  @override
  Widget build(BuildContext context) {
    List<CustomOrderContent> inProgressList = [];
    List<CustomOrderContent> postOrdersList = [];
    Iterable<dynamic> inProgress = allOrder.orders.where((element) =>
        element["food"]["status"] != "Canceled" &&
        element["food"]["status"] != "Finished");
    Iterable<dynamic> postOrders = allOrder.orders.where((element) =>
        element["food"]["status"] == "Canceled" ||
        element["food"]["status"] == "Finished");
    if (inProgress.isNotEmpty) {
      inProgressList = inProgress.map((e) {
        return CustomOrderContent(
          imageUrl: e["food"]["imageUrl"],
          title: e["food"]["name"],
          amount: e["food"]["quantity"],
          finalPrice: e["food"]["price"],
          status: e["food"]["status"],
          foodId: e["food"]["_id"],
          orderId: e["_id"],
        );
      }).toList();
    }
    if (postOrders.isNotEmpty) {
      postOrdersList = postOrders.map((e) {
        return CustomOrderContent(
          imageUrl: e["food"]["imageUrl"],
          title: e["food"]["name"],
          amount: e["food"]["quantity"],
          finalPrice: e["food"]["price"],
          isPost: true,
          status: e["food"]["status"],
        );
      }).toList();
    }

    Widget getContent(int page) {
      return page == 1
          ? Column(
              children: [
                const SizedBox(height: 8),
                Column(
                  children: inProgressList.isNotEmpty
                      ? inProgressList
                      : [
                          const SizedBox(
                            height: 62,
                          ),
                          const Center(
                            child: Text("Orders Empty"),
                          )
                        ],
                ),
                const SizedBox(height: 70),
              ],
            )
          : Column(
              children: [
                const SizedBox(height: 8),
                Column(
                  children: postOrdersList.isNotEmpty
                      ? postOrdersList
                      : [
                          const SizedBox(
                            height: 62,
                          ),
                          const Center(
                            child: Text("Orders Empty"),
                          )
                        ],
                ),
                const SizedBox(height: 70),
              ],
            );
    }

    return ListView(
      children: [
        Row(
          children: [
            const Expanded(
              child: Header(
                title: "Your Orders",
                subTitle: "Wait for the best meal",
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 24,
                right: 10,
              ),
              color: Colors.white,
              child: Visibility(
                child: IconButton(
                  icon: const Icon(Icons.payment),
                  onPressed: () {
                    if (allOrder.payments >= 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PaymentPage(amount: allOrder.payments),
                        ),
                      );
                    }
                  },
                ),
                visible: allOrder.payments >= 0 ? true : false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        HookBuilder(
          builder: ((context) {
            final pageState = useState(1);
            return Column(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: cSecondaryColor2),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 24),
                      GestureDetector(
                        onTap: () {
                          pageState.value = 1;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            Text("In Progress",
                                style: pageState.value == 1
                                    ? tBlackText
                                    : tGreyText),
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
                            Text("Post Orders",
                                style: pageState.value == 2
                                    ? tBlackText
                                    : tGreyText),
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
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: getContent(pageState.value),
                ),
              ],
            );
          }),
        )
      ],
    );
  }
}
