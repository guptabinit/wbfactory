import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/views/onboarding_screens/login_page.dart';

import 'colors.dart';

screenHeight(context) => MediaQuery.of(context).size.height;

screenWidth(context) => MediaQuery.of(context).size.width;

void customToast(String message, Color color, BuildContext context) {
  showToast(
    message,
    textStyle: const TextStyle(
      fontSize: 14,
      color: lightColor,
    ),
    isHideKeyboard: true,
    textPadding: const EdgeInsets.all(16),
    fullWidth: true,
    toastHorizontalMargin: 24,
    borderRadius: BorderRadius.circular(12),
    backgroundColor: color,
    alignment: Alignment.bottomLeft,
    animation: StyledToastAnimation.slideFromBottom,
    context: context,
  );
}

showLoginDialog(context) {
  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: lightColor,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "WB Factory",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: darkColor,
              ),
            ),
            12.heightBox,
            const Text(
              "You have to login/signup first",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: darkColor,
              ),
            ),
            16.heightBox,
            Row(
              children: [
                Expanded(
                  child: MainButton(
                    title: "Login",
                    onTap: () {
                      Get.offAll(() => const LoginPage());
                    },
                    fontSize: 14,
                  ),
                ),
                12.widthBox,
                Expanded(
                  child: MainButton(
                    title: "Cancel",
                    onTap: () {
                      Get.back();
                    },
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
