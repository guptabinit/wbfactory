import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/home_screens/main_nav_page.dart';
import 'package:wbfactory/views/order_screens/order_palaced_screens/new_order_placed_screen.dart';

class SomeErrorScreen extends StatefulWidget {
  const SomeErrorScreen({super.key});

  @override
  State<SomeErrorScreen> createState() => _SomeErrorScreenState();
}

class _SomeErrorScreenState extends State<SomeErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                          'https://lottie.host/7a26d89a-7440-49ba-a12d-757d1bff15f2/VDKyDvSqub.json',
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
                          "Some error occurred",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: darkColor,
                          ),
                        ),
                        8.heightBox,
                        const Text(
                          "If your amount is deducted it will be refunded in 2-3 working days",
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
          12.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "You can also contact the restaurant.",
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
