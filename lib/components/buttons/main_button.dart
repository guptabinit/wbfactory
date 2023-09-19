import 'package:flutter/material.dart';
import 'package:wbfactory/constants/colors.dart';

class MainButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final double? fontSize;
  final bool load;
  final Widget? mainWidget;

  const MainButton({
    super.key,
    required this.title,
    required this.onTap,
    this.fontSize = 16,
    this.load = false,
    this.mainWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: secondaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: load ? mainWidget : Text(
              title,
              style: TextStyle(
                color: lightColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
