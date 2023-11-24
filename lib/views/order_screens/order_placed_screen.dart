import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/home_screens/main_nav_page.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});

  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Lottie.network(
                        'https://lottie.host/285fe519-94f2-46d2-a26a-618a4bfcae2f/wgzKJxovQm.json',
                        repeat: true,
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.width * 0.85,
                      ),
                    ),
                    const Text(
                      "Order Placed Successfully",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: lightColor),
                    ),
                  ],
                ),
              ),
            ),
            12.heightBox,
            MainButton(
              title: "Go to Home",
              color: lightColor,
              textColor: primaryColor,
              onTap: () {
                Get.offAll(() => const NavScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
