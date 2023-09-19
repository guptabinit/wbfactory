import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/constants/colors.dart';

Widget backButton({required void Function()? onTap}) => TextButton(
      onPressed: onTap,
      style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: darkColor,
          ),
          8.widthBox,
          const Text(
            "Back",
            style: TextStyle(
              fontSize: 16,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
