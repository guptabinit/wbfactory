import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/views/home_screens/main_nav_page.dart';

import '../../components/buttons/back_button.dart';
import '../../components/buttons/main_button.dart';
import '../../constants/colors.dart';

class CartSummaryPage extends StatefulWidget {
  const CartSummaryPage({super.key});

  @override
  State<CartSummaryPage> createState() => _CartSummaryPageState();
}

class _CartSummaryPageState extends State<CartSummaryPage> {
  bool isPickup = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: backButton(
          onTap: () {
            Get.back();
          },
        ),
        leadingWidth: 90,
        actions: [
          IconButton(
            onPressed: () {
              Get.offAll(() => const NavScreen());
            },
            icon: const Icon(
              Icons.home_filled,
              color: secondaryColor,
            ),
          ),
          8.widthBox,
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Order Summary",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: darkColor,
                  ),
                ),
              ),
              12.heightBox,
              // Divider
              Container(
                height: 8,
                color: veryLightGreyColor,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                  child: Column(
                    children: [
                      fixedCartTile(),
                      fixedCartTile(),
                      fixedCartTile(),
                      // Divider
                      Container(
                        height: 8,
                        color: veryLightGreyColor,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          bottom: 16,
                          top: 4,
                        ),
                        decoration: const BoxDecoration(
                          color: whiteColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Coupon Code",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: darkColor,
                                    ),
                                  ),
                                ),
                                8.widthBox,
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("See All"),
                                ),
                              ],
                            ),
                            2.heightBox,
                            // text-field
                            Container(
                              decoration: BoxDecoration(
                                color: veryLightGreyColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  suffixIcon: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "APPLY",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 12,
                                  ),
                                  isDense: true,
                                  fillColor: veryLightGreyColor,
                                  hintText: "Enter the coupon code here",
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: darkGreyColor,
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            8.heightBox,
                            const Row(
                              children: [
                                Text(
                                  "Coupon Code applied",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: greenColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Divider
                      Container(
                        height: 8,
                        color: veryLightGreyColor,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: whiteColor,
                        ),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Text(
                                  "Payment Info",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                              ],
                            ),
                            12.heightBox,
                            const Row(
                              children: [
                                Text(
                                  "Order Mode : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Text(
                                  " Pick up",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            8.heightBox,
                            Row(
                              children: [
                                const Text(
                                  "Price : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                8.widthBox,
                                const Text(
                                  "\$ 100.00",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                              ],
                            ),
                            8.heightBox,
                            Row(
                              children: [
                                const Text(
                                  "Discount (CODE) : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                8.widthBox,
                                const Text(
                                  "-\$ 12.00",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                              ],
                            ),
                            8.heightBox,
                            Row(
                              children: [
                                const Text(
                                  "Tax (18%) : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                8.widthBox,
                                const Text(
                                  "\$ 18.00",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                              ],
                            ),
                            8.heightBox,
                            Row(
                              children: [
                                const Text(
                                  "Delivery Charges : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                8.widthBox,
                                const Text(
                                  "\$ 19.99",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Divider
                      Container(
                        height: 1,
                        color: lightGreyColor,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: whiteColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Total Amount",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                const Text(
                                  "\$ 125.99",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            12.heightBox,
                            const Row(
                              children: [
                                Text(
                                  "You save \$ 49.00 on this order",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: greenColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      84.heightBox,
                    ],
                  ),
                ),
              ),
              Container(),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 12,
            right: 12,
            child: MainButton(
              title: "Go to payment",
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget fixedCartTile() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: lightColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Container(
                  color: lightGreyColor,
                ),
              ),
              12.widthBox,
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Product Name",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: darkColor,
                            ),
                          ),
                          4.heightBox,
                          const Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: darkGreyColor,
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "\$ 12.80",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: darkColor,
                            ),
                          ),
                          Text(
                            " • Qty: 2",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: darkGreyColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: lightGreyColor,
          height: 1,
        )
      ],
    );
  }
}
