import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/constants/colors.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool isPass;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.isPass = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: veryLightGreyColor,
            borderRadius: BorderRadius.circular(8)
          ),
          child: TextField(
            keyboardType: widget.keyboardType,
            obscureText: widget.isPass,
            controller: widget.controller,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 12,
              ),
              isDense: true,
              fillColor: veryLightGreyColor,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: darkGreyColor,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
