import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/constants/colors.dart';

class OnboardingTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool isPass;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;

  const OnboardingTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.isPass = false,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatter,
  });

  @override
  State<OnboardingTextField> createState() => _OnboardingTextFieldState();
}

class _OnboardingTextFieldState extends State<OnboardingTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: darkColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        6.heightBox,
        TextField(
          inputFormatters: widget.inputFormatter,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPass,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: darkGreyColor,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: lightGreyColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        )
      ],
    );
  }
}
