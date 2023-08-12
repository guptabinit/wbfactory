import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/onboarding_screens/create_account_page.dart';
import 'package:wbfactory/views/onboarding_screens/forgot_password_page.dart';

import '../../components/textfield/onboarding_textfield.dart';
import '../home_screens/main_nav_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            72.heightBox,
            const Text(
              "Let’s get inside",
              style: TextStyle(
                color: darkColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            12.heightBox,
            const Text(
              "Come login with us to able to pick up or order food online.",
              style: TextStyle(
                color: darkGreyColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            24.heightBox,
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
              isPass: !isVisible,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: Icon(
                  isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: lightGreyColor,
                ),
              ),
            ),
            6.heightBox,
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => const ForgotPasswordPage());
                  },
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            8.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: MainButton(
                    title: "Continue",
                    onTap: () {
                      Get.to(() => const NavScreen());
                    },
                  ),
                ),
              ],
            ),
            16.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () { },
                  child: const Text(
                    "Continue without login",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Haven’t registered yet?",
                    style: TextStyle(
                      color: darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const CreateAccountPage());
                    },
                    child: const Text(
                      "Register",
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
