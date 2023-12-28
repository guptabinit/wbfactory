import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/views/onboarding_screens/login_page.dart';
import '../../../../components/buttons/back_button.dart';
import '../../../../components/buttons/main_button.dart';
import '../../../../components/cards/address_card.dart';
import '../../../../components/textfield/custom_textfield.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/consts.dart';
import '../../../../resources/auth_methods.dart';
import 'address/add_address_screen.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void deleteAccountFunction() async {
    setState(() {
      isLoading = true;
    });

    String message = await AuthMethods().deleteUser(email: emailController.text, password: passwordController.text);

    if (message == 'success') {
      setState(() {
        isLoading = false;
      });
      showingSnackBar("Account deleted successfully", greenColor);
      Get.offAll(() => const LoginPage());
    } else {
      setState(() {
        isLoading = false;
      });
      showingSnackBar("Error: $message", redColor);
    }
  }

  void showingSnackBar(message, color) {
    customToast("$message", color, context);
  }


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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delete Account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
            8.heightBox,
            const Text(
              "In order to delete your account you need to login again using your email and password.",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: darkGreyColor,
              ),
            ),
            8.heightBox,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    16.heightBox,
                    CustomTextfield(
                      controller: emailController,
                      hintText: "alex@email.com",
                      title: "Email Address",
                      showTitle: true,
                      keyboardType: TextInputType.name,
                    ),
                    12.heightBox,
                    CustomTextfield(
                      controller: passwordController,
                      hintText: "* * * * * *",
                      title: "Password",
                      isPass: true,
                      showTitle: true,
                      keyboardType: TextInputType.name,
                    ),
                    24.heightBox,
                    isLoading ? const Center(child: CircularProgressIndicator(color: secondaryColor,)) : MainButton(
                      title: "Changes Password",
                      onTap: () {
                        if (emailController.text != "" &&
                            passwordController.text != "") {

                          if(passwordController.text.length >= 6){
                            // do-something
                            deleteAccountFunction();
                          } else {
                            customToast("Password should at least 6 characters", redColor, context);
                          }

                        } else {
                          customToast("Enter all the fields first", redColor, context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
