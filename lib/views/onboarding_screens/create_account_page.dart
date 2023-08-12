import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/back_button.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/onboarding_screens/enter_phone_page.dart';

import '../../components/textfield/onboarding_textfield.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isVisibleP = false;
  bool isVisibleCP = false;

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
                child: backButton()),
            12.heightBox,
            const Text(
              "Create Account",
              style: TextStyle(
                color: darkColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            24.heightBox,
            OnboardingTextField(
              controller: fullNameController,
              title: "Full Name",
              hintText: "e.g. Alex Hales",
            ),
            12.heightBox,
            OnboardingTextField(
              controller: emailController,
              title: "Email Address",
              hintText: "e.g. alex@company.com",
            ),
            12.heightBox,
            OnboardingTextField(
              controller: passwordController,
              title: "Password",
              hintText: "********",
              isPass: !isVisibleP,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisibleP = !isVisibleP;
                  });
                },
                icon: Icon(
                  isVisibleP ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: lightGreyColor,
                ),
              ),
            ),
            12.heightBox,
            OnboardingTextField(
              controller: confirmPasswordController,
              title: "Confirm Password",
              hintText: "********",
              isPass: !isVisibleCP,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisibleCP = !isVisibleCP;
                  });
                },
                icon: Icon(
                  isVisibleCP ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: lightGreyColor,
                ),
              ),
            ),
            24.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: MainButton(
                    title: "Continue",
                    onTap: () {
                      Get.to(() => const EnterPhonePage(), transition: Transition.rightToLeftWithFade);
                    },
                  ),
                ),
              ],
            ),
            Expanded(child: Container(),),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            12.heightBox,
          ],
        ),
      ),
    );
  }
}
