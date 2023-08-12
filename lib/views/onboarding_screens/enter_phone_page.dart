import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/back_button.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/onboarding_screens/verification_page.dart';

import '../../components/textfield/onboarding_textfield.dart';
import '../../constants/consts.dart';

class EnterPhonePage extends StatefulWidget {
  const EnterPhonePage({super.key});

  @override
  State<EnterPhonePage> createState() => _EnterPhonePageState();
}

class _EnterPhonePageState extends State<EnterPhonePage> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            64.heightBox,
            GestureDetector(
              onTap: () => Get.back(),
              child: backButton(),
            ),
            12.heightBox,
            const Text(
              "Phone Verification",
              style: TextStyle(
                color: darkColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            24.heightBox,
            OnboardingTextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              title: "Mobile Number",
              hintText: "+1 123-0023-120",
            ),
            24.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: MainButton(
                    title: "Send Verification Code",
                    onTap: () {
                      Get.to(() => const VerificationPage(), transition: Transition.rightToLeftWithFade);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
