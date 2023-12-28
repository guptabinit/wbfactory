import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/consts.dart';
import 'package:wbfactory/views/onboarding_screens/login_page.dart';

import '../../components/cards/promotional_card.dart';
import '../../constants/colors.dart';
import '../../models/user_model.dart' as user_model;
import '../../resources/auth_methods.dart';

class OffersPage extends StatefulWidget {

  final bool userAvailable;
  const OffersPage({super.key, required this.userAvailable});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  user_model.User? user;

  bool showCoins = false;

  @override
  void initState() {
    super.initState();
    if(widget.userAvailable){
      try {
        getUserData();
      } catch (e) {
        print("Error while fetching user");
      }
    }
  }

  getUserData() async {
    var tempUser = await AuthMethods().getUserDetails();
    setState(() {
      user = tempUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.heightBox,
              const Text(
                "Your Offers",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: darkColor,
                ),
              ),
              8.heightBox,
              const Text(
                "Here you will find all the active discounts and offers running on our app.",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: darkGreyColor,
                ),
              ),
              12.heightBox,
              // Coins Section
              widget.userAvailable ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/coins.webp",
                      height: 100,
                      width: 100,
                      fit: BoxFit.fitHeight,
                    ),
                    16.widthBox,
                    showCoins
                        ? Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "You have",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: lightColor,
                                  ),
                                ),
                                2.heightBox,
                                user == null
                                    ? const Text(
                                        "-- WB Coins",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: lightColor,
                                        ),
                                      )
                                    : Text(
                                        "${user!.coins} WB Coins",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: lightColor,
                                        ),
                                      ),
                                6.heightBox,
                                const Text(
                                  "1 WB Coin = \$1.00",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: lightColor,
                                  ),
                                ),
                                2.heightBox,
                                const Text(
                                  "You can use them in your next purchase on WB App.",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: lightColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Stay Tuned!",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: lightColor,
                                  ),
                                ),
                                4.heightBox,
                                const Text(
                                  "WB Coins are coming soon!",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: lightColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Container(),
                  ],
                ),
              ) : MainButton(title: "Login/Signup to view more", onTap: (){ Get.offAll(() => const LoginPage()); }),
              16.heightBox,
              const Text(
                "Promo-codes for you",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: darkColor,
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('commons')
                    .doc("coupons")
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  var snap = snapshot.data!;
                  var orderLength = snap['code_list'].length;

                  return orderLength == 0
                      ? Expanded(
                          child: Center(
                            child: Lottie.network(
                              'https://lottie.host/1c93e52f-afdd-4f2e-9697-d66e27256df4/5jlcTbp7Ss.json',
                              repeat: true,
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.width * 0.7,
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(top: 12),
                          itemCount: orderLength,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            var mainSnap = snap[snap['code_list'][index]];

                            return PromotionalCard(snap: mainSnap, couponPage: false,);
                          },
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}
