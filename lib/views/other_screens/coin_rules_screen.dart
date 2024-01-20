
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../components/buttons/back_button.dart';
import '../../constants/colors.dart';

class CoinRulesScreen extends StatefulWidget {
  const CoinRulesScreen({super.key});

  @override
  State<CoinRulesScreen> createState() => _CoinRulesScreenState();
}

class _CoinRulesScreenState extends State<CoinRulesScreen> {

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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Rules for coins",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
          ),
          12.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const Text(
              '1. Every dollar you spent, you will get 1 "WB Coin". So if you spent \$15.00 then you will get 15 WB Coins, if you spent \$15.80 you will get 15 WB Coins. So it will round off to last natural number.\n\n2. 100 WB Coins = \$8 which you can redeem.\n\n3. You can only redeem coins in multiple of 100. So it can be 100, 200, 300 and so on… So if you have 250 coins, you can only use 200 coins. And 50 will be in the balance.\n\n4. If you have total order value less than \$8 and you have 100 coins then you can\'t redeem it. You have to have atleast \$8+ in your cart.',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
