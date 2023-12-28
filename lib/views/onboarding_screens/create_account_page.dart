import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/back_button.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/onboarding_screens/enter_phone_page.dart';

import '../../components/textfield/onboarding_textfield.dart';
import '../../constants/consts.dart';
import '../../resources/auth_methods.dart';
import '../home_screens/main_nav_page.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isVisibleP = false;
  bool isVisibleCP = false;
  bool isLoading = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void createUser(data) async {
    setState(() {
      isLoading = true;
    });

    String message = await AuthMethods().signUpUser(data: data);

    if (message == 'success') {

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogin', true);

      setState(() {
        isLoading = false;
      });

      toast("Account created successfully", greenColor);

      Get.offAll(() => const NavScreen());

    } else {

      setState(() {
        isLoading = false;
      });
      await toast(message, redColor);

    }
  }

  Future<dynamic> toast(message, color) async {
    return customToast("$message", color, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: backButton(
          onTap: () {
            Get.back();
          },
        ),
        leadingWidth: 90,
        elevation: 0,
        backgroundColor: lightColor,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create Account",
              style: TextStyle(
                color: darkColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            24.heightBox,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                      keyboardType: TextInputType.emailAddress,
                    ),
                    12.heightBox,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: lightGreyColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "🇺🇸",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        8.widthBox,
                        Expanded(
                          child: OnboardingTextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            title: "Mobile Number",
                            hintText: "123-1234-123",
                          ),
                        ),
                      ],
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
                          child: isLoading ? const Center(child: CircularProgressIndicator(color: secondaryColor,),) : MainButton(
                            title: "Continue",
                            onTap: () {
                              if (fullNameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty && phoneController.text.isNotEmpty) {
                                if (passwordController.text.length < 6) {
                                  customToast("Please enter a password greater than 6 characters", redColor, context);
                                } else if (passwordController.text != confirmPasswordController.text) {
                                  customToast("Password does not match with confirm password", redColor, context);
                                } else if (phoneController.text.length != 10) {
                                  customToast("Please enter the correct phone number", redColor, context);
                                } else if (!EmailValidator.validate(emailController.text)) {
                                  customToast("Enter a correct email address", redColor, context);
                                } else {
                                  final Map<String, String> data = {
                                    'full_name': fullNameController.text,
                                    'email': emailController.text,
                                    'password': passwordController.text,
                                    'phone': "+1${phoneController.text}",
                                  };
                
                                  // do-something
                                  createUser(data);
                                }
                              } else {
                                customToast("Please enter all the details", redColor, context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
