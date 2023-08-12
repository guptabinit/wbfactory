import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/views/drawer/drawer_body.dart';
import 'package:wbfactory/views/drawer/drawer_header.dart';
import 'package:wbfactory/views/home_screens/categories_page.dart';
import 'package:wbfactory/views/home_screens/home_page.dart';
import 'package:wbfactory/views/home_screens/offers_page.dart';
import 'package:wbfactory/views/home_screens/orders_page.dart';

import '../../constants/colors.dart';

class NavScreen extends StatefulWidget {
  final int currentIndex;

  const NavScreen({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.currentIndex;
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
      drawer: const Drawer(
        shape: RoundedRectangleBorder(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: HeaderDrawer(),
              ),
              DrawerList(),
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
              onPressed: () {},
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
