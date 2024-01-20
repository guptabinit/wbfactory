import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/home_screens/main_nav_page.dart';
import 'package:wbfactory/views/order_screens/order_palaced_screens/order_rejected_screen.dart';

class NewOrderPlacedScreen extends StatefulWidget {
  const NewOrderPlacedScreen({super.key});

  @override
  State<NewOrderPlacedScreen> createState() => _NewOrderPlacedScreenState();
}

class _NewOrderPlacedScreenState extends State<NewOrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
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
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  12.heightBox,

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
                        "Order Accepted",
                        style: TextStyle(
                            fontWeight: FontWeight.w500
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
                          'https://lottie.host/285fe519-94f2-46d2-a26a-618a4bfcae2f/wgzKJxovQm.json',
                          repeat: true,
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.width * 0.85,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Order Placed Successfully!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: lightColor,
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
              color: lightColor,
              textColor: primaryColor,
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
