import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wbfactory/resources/auth_methods.dart';
import 'package:wbfactory/views/drawer/drawer_body.dart';
import 'package:wbfactory/views/drawer/drawer_header.dart';
import 'package:wbfactory/views/home_screens/categories_page.dart';
import 'package:wbfactory/views/home_screens/home_page.dart';
import 'package:wbfactory/views/home_screens/offers_page.dart';
import 'package:wbfactory/views/home_screens/orders_page.dart';
import 'package:wbfactory/models/user_model.dart' as user_model;
import 'package:wbfactory/views/other_screens/cart_page.dart';
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

    getSharedPrefDetails();

    // try {
    //   getUser();
    // } catch (e) {
    //   print("Error while fetching user");
    // }

    // if(userAvailable){
    //   try {
    //     getUser();
    //   } catch (e) {
    //     if (kDebugMode) {
    //       print("Error while fetching user");
    //     }
    //   }
    // }

  }

  getSharedPrefDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isLogin = prefs.getBool('isLogin');

    if(isLogin == true && isLogin != null) {
      try {
        getUser();
      } catch (e) {
        print("Error while fetching user");
      }
    }

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

  getUserData() async {
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
      HomePage(userAvailable: userAvailable),
      CategoriesPage(userAvailable: userAvailable),
      OrdersPage(userAvailable: userAvailable),
      OffersPage(userAvailable: userAvailable),
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
                  userAvailable: userAvailable,
                ),
              ),
              DrawerList(
                userAvailable: userAvailable,
              ),
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
                userAvailable
                    ? Get.to(() => const CartPage())
                    : showLoginDialog(context);
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
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: "Category"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), label: "Orders"),
          BottomNavigationBarItem(
              icon: Icon(Icons.discount_outlined), label: "Offers"),
        ],
      ),
    );
  }
}
