import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../components/buttons/back_button.dart';
import '../../../../components/buttons/main_button.dart';
import '../../../../components/textfield/custom_textfield.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/consts.dart';
import '../../../../resources/auth_methods.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  bool isLoading = false;

  void changePasswordFunction() async {
    setState(() {
      isLoading = true;
    });

    String message = await AuthMethods().changePassword(oldPassword: oldPassController.text, newPassword: newPassController.text);

    if (message == 'success') {
      setState(() {
        isLoading = false;
      });
      showingSnackBar("Password changed successfully", greenColor);
      Get.back();
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
              "Change Password",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
            8.heightBox,
            const Text(
              "Here you can change password of your account.",
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
                      controller: oldPassController,
                      hintText: "* * * * * *",
                      title: "Old Password",
                      showTitle: true,
                      keyboardType: TextInputType.name,
                    ),
                    12.heightBox,
                    CustomTextfield(
                      controller: newPassController,
                      hintText: "* * * * * *",
                      title: "New Password",
                      showTitle: true,
                      keyboardType: TextInputType.name,
                    ),
                    24.heightBox,
                    isLoading ? const Center(child: CircularProgressIndicator(color: secondaryColor,)) : MainButton(
                      title: "Changes Password",
                      onTap: () {
                        if (oldPassController.text != "" &&
                            newPassController.text != "") {

                          if(oldPassController.text.length >= 6 &&
                              newPassController.text.length >= 6 ){
                            // do-something
                            changePasswordFunction();
                          } else {
                            customToast("All password should at least 6 characters", redColor, context);
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
