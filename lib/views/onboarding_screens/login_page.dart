import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/onboarding_screens/create_account_page.dart';
import 'package:wbfactory/views/onboarding_screens/forgot_password_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/textfield/onboarding_textfield.dart';
import '../../constants/consts.dart';
import '../../resources/auth_methods.dart';
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
  bool isLoading = false;

  void loginUser() async {
    setState(() {
      isLoading = true;
    });

    String message = await AuthMethods().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (message == 'success') {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogin', true);

      setState(() {
        isLoading = false;
      });

      Get.offAll(() => const NavScreen());
    } else {
      setState(() {
        isLoading = false;
      });
      await toast(message);
    }
  }

  Future<dynamic> toast(message) async {
    return customToast("error: $message", redColor, context);
  }

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
                    title: "Login",
                    load: true,
                    mainWidget: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: lightColor,
                            ),
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(
                              color: lightColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    onTap: () async {
                      if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                        if (passwordController.text.length < 6) {
                          customToast("Please enter a password greater than 6 characters", redColor, context);
                        } else if (!EmailValidator.validate(emailController.text)) {
                          customToast("Enter a correct email address", redColor, context);
                        } else {
                          loginUser();
                        }
                      } else {
                        customToast("Please enter all the details", redColor, context);
                      }
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
                  onPressed: () {
                    Get.to(() => const NavScreen());
                  },
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
