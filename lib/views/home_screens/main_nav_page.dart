import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/resources/auth_methods.dart';
import 'package:wbfactory/views/drawer/drawer_body.dart';
import 'package:wbfactory/views/drawer/drawer_header.dart';
import 'package:wbfactory/views/home_screens/categories_page.dart';
import 'package:wbfactory/views/home_screens/home_page.dart';
import 'package:wbfactory/views/home_screens/offers_page.dart';
import 'package:wbfactory/views/home_screens/orders_page.dart';
import 'package:wbfactory/models/user_model.dart' as user_model;
import 'package:wbfactory/views/other_screens/cart_page.dart';
import 'package:wbfactory/views/other_screens/test_screen.dart';
import '../../constants/colors.dart';
import '../../constants/consts.dart';

class NavScreen extends StatefulWidget {
  final int currentIndex;

  const NavScreen({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int currentIndex = 0;

  user_model.User? user;
  bool userAvailable = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    try {
      getUser();
    } catch (e) {
      print("Error while fetching user");
    }
    getSharedPrefDetails();
  }

  getSharedPrefDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isLogin = prefs.getBool('isLogin');
    setState(() {
      userAvailable = isLogin ?? false;
    });
  }

  getUser() async {
    var tempUser = await AuthMethods().getUserDetails();
    setState(() {
      user = tempUser;
    });
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      const HomePage(),
      const CategoriesPage(),
      const OrdersPage(),
      const OffersPage(),
    ];

    return Scaffold(
      drawer: Drawer(
        shape: const RoundedRectangleBorder(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: HeaderDrawer(
                  user: user,
                ),
              ),
              const DrawerList(),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(
              CupertinoIcons.bars,
              color: secondaryColor,
              size: 28,
            ),
          );
        }),
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: lightGreyColor,
        // ),
        elevation: 0,
        backgroundColor: lightColor,
        title: Image.asset(
          'assets/images/vertical_transparent_logo.webp',
          height: 36,
          fit: BoxFit.fitHeight,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                userAvailable ? Get.to(() => const CartPage()) : showLoginDialog(context);
              },
              icon: const Icon(
                CupertinoIcons.shopping_cart,
                color: secondaryColor,
              ),
            ),
          ),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: whiteColor,
        unselectedItemColor: darkGreyColor,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        showUnselectedLabels: true,
        selectedItemColor: secondaryColor,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.discount_outlined), label: "Offers"),
        ],
      ),
    );
  }
}
