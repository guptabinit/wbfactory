import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({super.key});

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 14,
                        color: darkColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Mr. June Park",
                      style: TextStyle(
                        fontSize: 24,
                        color: darkColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(color: darkGreyColor,),
                    Text("20+ orders so far")
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
