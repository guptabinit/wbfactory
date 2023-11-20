import 'package:flutter/material.dart';
import 'package:wbfactory/constants/colors.dart';

class MainButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final double? fontSize;
  final bool load;
  final Widget? mainWidget;
  final Color color;
  final Color textColor;
  final double vertP;

  const MainButton({
    super.key,
    required this.title,
    required this.onTap,
    this.fontSize = 16,
    this.load = false,
    this.mainWidget,
    this.color = secondaryColor,
    this.textColor = lightColor,
    this.vertP = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: color,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          padding:  EdgeInsets.symmetric(vertical: vertP),
          child: Center(
            child: load ? mainWidget : Text(
              title,
              style: TextStyle(
                color: textColor,
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
