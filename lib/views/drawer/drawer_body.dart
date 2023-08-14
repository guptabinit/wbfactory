import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';
import '../home_screens/main_nav_page.dart';
import '../onboarding_screens/login_page.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({super.key});

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            onTap: (){
              Get.offAll(() => const NavScreen(currentIndex: 2,));
            },
            title: const Text("Your orders"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: secondaryColor,
            ),
          ),
          ListTile(
            onTap: (){
            },
            title: const Text("Your reviews"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: secondaryColor,
            ),
          ),
          ListTile(
            onTap: (){
            },
            title: const Text("Your favourites"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: secondaryColor,
            ),
          ),
          ListTile(
            onTap: (){
            },
            title: const Text("Settings"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: secondaryColor,
            ),
          ),
          ListTile(
            onTap: (){
            },
            title: const Text("Privacy Policy"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: secondaryColor,
            ),
          ),
          ListTile(
            onTap: (){
              Get.offAll(() => const LoginPage());
            },
            title: const Text("Log out"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}