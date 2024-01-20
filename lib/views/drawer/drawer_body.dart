import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wbfactory/views/drawer/drawer_screens/your_favourites_page.dart';

import '../../constants/colors.dart';
import '../../constants/consts.dart';
import '../../resources/auth_methods.dart';
import '../home_screens/main_nav_page.dart';
import '../onboarding_screens/login_page.dart';
import '../other_screens/store_info.dart';
import 'drawer_screens/settings_page.dart';

class DrawerList extends StatefulWidget {
  final bool userAvailable;
  const DrawerList({super.key, required this.userAvailable});

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {

  bool isLoading = false;

  void logoutUser() async {
    setState(() {
      isLoading = true;
    });

    String message = await AuthMethods().signOut();

    setState(() {
      isLoading = false;
    });
    if (message == 'success') {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogin', false);
      Get.offAll(() => const LoginPage());
    } else {
      await toast(message);
    }
  }

  Future<dynamic> toast(message) async {
    return customToast("error: $message", redColor, context);
  }


  final Uri url = Uri.parse(
      "https://whitestonebagelfactory.com/terms-conditions/");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            onTap: (){
              Get.offAll(() => const NavScreen(currentIndex: 0,));
            },
            title: const Text("Home"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: secondaryColor,
            ),
          ),
          ListTile(
            onTap: (){
              !widget.userAvailable ? showLoginDialog(context) : Get.offAll(() => const NavScreen(currentIndex: 2,));
            },
            title: const Text("Your orders"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: secondaryColor,
            ),
          ),
          ListTile(
            onTap: (){
              Get.to(() => const LocationPage());
            },
            title: const Text("Store Location"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: secondaryColor,
            ),
          ),
          // ListTile(
          //   onTap: (){
          //     Get.to(() => const YourReviewsPage());
          //   },
          //   title: const Text("Your reviews"),
          //   trailing: const Icon(
          //     Icons.keyboard_arrow_right,
          //     color: secondaryColor,
          //   ),
          // ),
          ListTile(
            onTap: (){
              !widget.userAvailable ? showLoginDialog(context) : Get.to(() => const YourFavouritesPage());
            },
            title: const Text("Your favourites"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: secondaryColor,
            ),
          ),
          ListTile(
            onTap: (){
              !widget.userAvailable ? showLoginDialog(context) : Get.to(() => const SettingsPage());
            },
            title: const Text("Settings"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: secondaryColor,
            ),
          ),
          ListTile(
            onTap: (){
              launchUrl(url);
            },
            title: const Text("Privacy Policy"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: secondaryColor,
            ),
          ),
          ListTile(
            onTap: () async {
              !widget.userAvailable ?  Get.offAll(() => const LoginPage()) : logoutUser();
            },
            title: Text(widget.userAvailable ? "Log out" : "Login/Signup"),
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