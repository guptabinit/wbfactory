import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'colors.dart';

screenHeight(context) => MediaQuery.of(context).size.height;

screenWidth(context) => MediaQuery.of(context).size.width;

void customToast(String message, Color color, BuildContext context) {
  showToast(
    message,
    textStyle: const TextStyle(
      fontSize: 14,
      color: lightColor,
    ),
    textPadding: const EdgeInsets.all(16),
    fullWidth: true,
    toastHorizontalMargin: 24,
    borderRadius: BorderRadius.circular(12),
    backgroundColor: color,
    alignment: Alignment.bottomLeft,
    animation: StyledToastAnimation.slideFromBottom,
    context: context,
  );
}