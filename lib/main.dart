import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/provider/user_provider.dart';
import 'package:wbfactory/views/onboarding_screens/splash.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Whitestone Bagel Factory',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: lightColor,
          colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor),
          fontFamily: "Poppins",
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
