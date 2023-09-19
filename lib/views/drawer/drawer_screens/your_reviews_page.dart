import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';
import '../../../components/buttons/back_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/consts.dart';

class YourReviewsPage extends StatefulWidget {
  const YourReviewsPage({super.key});

  @override
  State<YourReviewsPage> createState() => _YourReviewsPageState();
}

class _YourReviewsPageState extends State<YourReviewsPage> {
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
          TextButton(
            onPressed: () {
              customToast("No order to review", secondaryColor, context);
            },
            child: const Row(
              children: [
                Text(
                  "Add review ",
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.add),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Reviews",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
            8.heightBox,
            const Text(
              "Here you can take look at all your reviews on your previous orders.",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: darkGreyColor,
              ),
            ),
            12.heightBox,
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.network(
                      'https://lottie.host/25ed82d5-515a-4374-a0a1-3164100bbb39/pdXnJyWWWw.json',
                      repeat: true,
                      width: screenWidth(context) * 0.75,
                    ),
                    16.heightBox,
                    const Text(
                      "Write your first review.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: darkGreyColor,
                      ),
                    ),
                    64.heightBox,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
