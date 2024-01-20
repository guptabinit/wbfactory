import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/models/user_model.dart' as user_model;

import '../../constants/colors.dart';
import '../onboarding_screens/login_page.dart';

class HeaderDrawer extends StatelessWidget {
  final user_model.User? user;
  final bool userAvailable;
  const HeaderDrawer({super.key, this.user, required this.userAvailable});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome to",
                style: TextStyle(
                  fontSize: 16,
                  color: darkColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                "Whitestone Bagel Factory",
                style: TextStyle(
                  fontSize: 28,
                  color: secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              16.heightBox,
              !userAvailable ? MainButton(title: "Login/Signup", onTap: (){ Get.offAll(() => const LoginPage()); }) : Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: lightBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 14,
                        color: darkColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    user == null ? const Text(
                      "Error",
                      style: TextStyle(
                        fontSize: 24,
                        color: darkColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ) : Text(
                      user!.fullName,
                      style: const TextStyle(
                        fontSize: 24,
                        color: darkColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Divider(color: darkGreyColor,),
                    // user == null ? const Text("You haven't order anything") : Text("${user!.totalOrders}+ orders so far")
                    const Text("Thanks for coming back 😄"),
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider(color: darkGreyColor,)
      ],
    );
  }
}
