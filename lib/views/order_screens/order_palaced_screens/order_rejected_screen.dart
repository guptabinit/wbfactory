import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/home_screens/main_nav_page.dart';
import 'package:wbfactory/views/order_screens/order_palaced_screens/new_order_placed_screen.dart';

class OrderRejectedScreen extends StatefulWidget {
  const OrderRejectedScreen({super.key});

  @override
  State<OrderRejectedScreen> createState() => _OrderRejectedScreenState();
}

class _OrderRejectedScreenState extends State<OrderRejectedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                )),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: greenColor,
                        child: Icon(
                          Icons.done,
                          color: lightColor,
                        ),
                      ),
                      12.widthBox,
                      Text(
                        "Payment Accepted",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  12.heightBox,
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: redColor,
                        child: Icon(
                          Icons.cancel_outlined,
                          color: lightColor,
                        ),
                      ),
                      12.widthBox,
                      Expanded(
                        child: Text(
                          "Order was rejected",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  12.heightBox,
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: Icon(
                          Icons.warning_amber_sharp,
                          color: lightColor,
                        ),
                      ),
                      12.widthBox,
                      Expanded(
                        child: Text(
                          "Refund is in process...",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 280,
                        width: 280,
                        child: Container(
                          // color: Colors.amberAccent,
                          child: Lottie.network(
                            'https://lottie.host/d07fd2bb-d19c-45d9-831e-94d6cc9a3b32/sfBSezK8hA.json',
                            repeat: true,
                            fit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.width * 0.85,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "We are Sorry!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: darkColor,
                            ),
                          ),
                          8.heightBox,
                          const Text(
                            "Your order was rejected by the restaurant",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: darkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          12.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Don’t worry we are processing the refund. You will receive it in 2-3 working days",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: textDarkGreyColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: MainButton(
              title: "Go to Home",
              color: secondaryColor,
              textColor: lightColor,
              onTap: () {
                Get.offAll(() => const NavScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
