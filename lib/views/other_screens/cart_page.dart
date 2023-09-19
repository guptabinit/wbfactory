import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/views/home_screens/main_nav_page.dart';
import 'package:wbfactory/views/order_screens/order_summary_page.dart';

import '../../components/buttons/back_button.dart';
import '../../components/buttons/main_button.dart';
import '../../constants/colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
                  "Cart",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: darkColor,
                  ),
                ),
              ),
              12.heightBox,
              // Pickup - Delivery option tab
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: lightColor,
                    border: Border.all(
                      color: lightGreyColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPickup = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: isPickup ? secondaryColor : lightColor,
                            ),
                            child: Center(
                              child: Text(
                                "Pick up",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isPickup ? lightColor : darkColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      8.widthBox,
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPickup = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: isPickup ? lightColor : secondaryColor,
                            ),
                            child: Center(
                              child: Text(
                                "Delivery",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isPickup ? darkColor : lightColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                      cartTile(),
                      cartTile(),
                      cartTile(),
                      cartTile(),
                      cartTile(),
                      cartTile(),
                      cartTile(),
                      cartTile(),
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
              title: "Continue",
              onTap: () {
                Get.to(() => const CartSummaryPage());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget cartTile() {
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
                      Row(
                        children: [
                          const Text(
                            "\$ 12.80",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: darkColor,
                            ),
                          ),
                          Expanded(child: Container()),
                          GestureDetector(
                            onTap: (){
                              print("Pressed: remove");
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: secondaryColor,
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: lightColor,
                              ),
                            ),
                          ),
                          12.widthBox,
                          const Text(
                            "2",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: darkColor,
                            ),
                          ),
                          12.widthBox,
                          GestureDetector(
                            onTap: (){
                              print("Pressed: add");
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: secondaryColor,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: lightColor,
                              ),
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
