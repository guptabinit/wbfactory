import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/constants/consts.dart';

import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(
      const Duration(seconds: 2),
      () => Get.off(() => const LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Image.asset(
              "assets/images/blue_logo.webp",
              height: screenWidth(context) * 0.8,
              width: screenWidth(context) * 0.8,
              fit: BoxFit.cover,
            ),
            Flexible(
              child: Container(),
            ),
            const CircularProgressIndicator(
              color: secondaryColor,
              backgroundColor: lightGreyColor,
            ),
            54.heightBox,
            const Text(
              "Powered by JP Digital Agency",
              style: TextStyle(
                color: lightColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            24.heightBox,
          ],
        ),
      ),
    );
  }
}
