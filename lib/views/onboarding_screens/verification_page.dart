import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/back_button.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/resources/auth_methods.dart';

import '../../components/textfield/onboarding_textfield.dart';
import '../../constants/consts.dart';
import '../home_screens/main_nav_page.dart';

class VerificationPage extends StatefulWidget {
  final String verificationId;
  final Map<String, String> signUpData;
  final String mobileNumber;

  const VerificationPage({
    super.key,
    required this.verificationId,
    required this.signUpData,
    required this.mobileNumber,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  void createUser() async {
    setState(() {
      isLoading = true;
    });

    String message = await AuthMethods().verifyCode(
      verificationId: widget.verificationId,
      smsCode: phoneController.text,
      context: context,
    );


    if (message == 'success') {
      String res = await AuthMethods().signUpUser(
        email: widget.signUpData['email']!,
        fullName: widget.signUpData['full_name']!,
        mobile: "+1${widget.mobileNumber}",
        password: widget.signUpData['password']!,
        isVerified: true,
      );

      if (res == 'success') {
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
        await toast(res);
      }
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
            24.heightBox,
            OnboardingTextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              title: "Verification Code",
              hintText: "1 2 3 4 5 6",
            ),
            24.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: MainButton(
                    title: "Continue & Verify",
                    load: true,
                    mainWidget: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: lightColor,
                            ),
                          )
                        : const Text(
                            "Continue & Verify",
                            style: TextStyle(
                              color: lightColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    onTap: () async {
                      if (phoneController.text.isNotEmpty) {
                        if (phoneController.text.length == 6) {
                          createUser();
                        } else {
                          customToast("Code have 6 characters", redColor, context);
                        }
                      } else {
                        customToast("Please enter the code", redColor, context);
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
                    customToast("Wait for a while", redColor, context);
                  },
                  child: const Text(
                    "Resend Code",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
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
