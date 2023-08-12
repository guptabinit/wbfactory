import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/onboarding_screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Whitestone Bagel Factory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: lightColor,
        colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor),
        fontFamily: "Poppins",
      ),
      home: const SplashScreen(),
    );
  }
}
