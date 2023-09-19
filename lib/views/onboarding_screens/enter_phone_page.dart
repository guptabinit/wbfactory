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
import '../../resources/auth_methods.dart';

class EnterPhonePage extends StatefulWidget {
  final Map<String, String> signUpData;

  const EnterPhonePage({super.key, required this.signUpData});

  @override
  State<EnterPhonePage> createState() => _EnterPhonePageState();
}

class _EnterPhonePageState extends State<EnterPhonePage> {
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  void sendVerificationFunction() async {
    setState(() {
      isLoading = true;
    });

    String message = await AuthMethods().sendVerificationCode(
      phoneNumber: "+91${phoneController.text}",
      signUpData: widget.signUpData,
      context: context,
    );

    setState(() {
      isLoading = false;
    });
    if (message == 'success') {
    } else {
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
              "Phone Verification",
              style: TextStyle(
                color: darkColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            12.heightBox,
            const Text(
              "Please enter the phone number carefully as you only have 5 wrong attempts.",
              style: TextStyle(
                color: darkGreyColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            24.heightBox,
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
            24.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: MainButton(
                    title: "Send Verification Code",
                    load: true,
                    mainWidget: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: lightColor,
                            ),
                          )
                        : const Text(
                            "Send Verification Code",
                            style: TextStyle(
                              color: lightColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (phoneController.text.isNotEmpty) {
                        if (phoneController.text.length == 10) {
                          await AuthMethods().sendVerificationCode(phoneNumber: phoneController.text, signUpData: widget.signUpData, context: context);
                          setState(() {
                            isLoading = false;
                          });
                          // Get.to(() => VerificationPage(signUpData: widget.signUpData, mobileNumber: phoneController.text), transition: Transition.rightToLeftWithFade);
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          customToast("Please enter the correct phone number", redColor, context);
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        customToast("Please enter the phone number", redColor, context);
                      }
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
