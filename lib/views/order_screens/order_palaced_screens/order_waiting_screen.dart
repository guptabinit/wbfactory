import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/home_screens/main_nav_page.dart';
import 'package:wbfactory/views/order_screens/order_palaced_screens/new_order_placed_screen.dart';

class OrderWaitingScreen extends StatefulWidget {
  final bool isPaid;
  const OrderWaitingScreen({super.key, required this.isPaid});

  @override
  State<OrderWaitingScreen> createState() => _OrderWaitingScreenState();
}

class _OrderWaitingScreenState extends State<OrderWaitingScreen> {
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
                  !widget.isPaid ? Container() : Row(
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
                        style: TextStyle(
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  !widget.isPaid ? Container() : 12.heightBox,

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
                          "Waiting for restaurant to accept the order",
                          style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
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
                          'https://lottie.host/b46e35de-f807-4919-baaf-c1762af04891/JnTGfVrJH8.json',
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
                    child: const Text(
                      "Waiting for restaurant to accept the order",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: darkColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          12.heightBox,
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
          12.heightBox,
        ],
      ),
    );
  }
}
