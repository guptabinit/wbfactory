import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/models/user_model.dart' as user_model;

import '../../constants/colors.dart';

class HeaderDrawer extends StatelessWidget {
  final user_model.User? user;
  const HeaderDrawer({super.key, this.user});

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
              Container(
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
                    user == null ? const Text("You haven't order anything") : Text("${user!.totalOrders}+ orders so far")
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider(color: darkColor,)
      ],
    );
  }
}
