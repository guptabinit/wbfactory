import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/models/coins.dart';
import 'package:wbfactory/resources/reward_methods.dart';
import 'package:wbfactory/views/onboarding_screens/login_page.dart';
import 'package:wbfactory/views/other_screens/coin_rules_screen.dart';

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
    if (widget.userAvailable) {
      try {
        getUserData();
      } catch (e) {
        print('Error while fetching user');
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
                'Your Offers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: darkColor,
                ),
              ),
              8.heightBox,
              const Text(
                'Here you will find all the active discounts and offers running on our app.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: darkGreyColor,
                ),
              ),
              12.heightBox,
              // Coins Section
              widget.userAvailable
                  ? StreamBuilder<Coins>(
                      stream: RewardMethods.coinsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Coins? coins = snapshot.data;

                          return _WBCoinsView(
                            totalCoins: coins?.coins?.toDouble() ?? 0,
                            totalCash: coins?.cash?.toDouble() ?? 0,
                          );
                        }
                        return SizedBox.shrink();
                      },
                    )
                  : MainButton(
                      title: 'Login/Signup to view more',
                      onTap: () {
                        Get.offAll(() => const LoginPage());
                      },
                    ),
              12.heightBox,
              MainButton(
                title: "Click here for rules",
                onTap: () {
                  Get.to(()=> CoinRulesScreen());
                },
                color: secondaryColor.withOpacity(0.16),
                textColor: secondaryColor,
                fontSize: 14,
              ),
              16.heightBox,
              const Text(
                'Promo-codes for you',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: darkColor,
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('commons')
                    .doc('coupons')
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
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 12),
                          itemCount: orderLength,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            var mainSnap = snap[snap['code_list'][index]];

                            return PromotionalCard(
                              snap: mainSnap,
                              couponPage: false,
                            );
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

class _WBCoinsView extends StatelessWidget {
  final double totalCash;
  final double totalCoins;

  const _WBCoinsView({
    required this.totalCoins,
    required this.totalCash,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Image.asset(
                  'assets/images/coins.webp',
                  height: 100,
                  width: 100,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15)
                      .copyWith(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You have',
                        style: textStyle.copyWith(fontWeight: FontWeight.w600),
                      ),
                      4.heightBox,
                      Text(
                        '${totalCoins.toStringAsFixed(0)} WB Coins',
                        style: textStyle.copyWith(fontSize: 22),
                      ),
                      8.heightBox,
                      Text(
                        '100 WB Coin = \$8.00',
                        style: textStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      4.heightBox,
                      Text(
                        'You can use them in your next purchase on WB App.',
                        style: textStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        10.heightBox,
        Text.rich(
          TextSpan(
            text: 'You have WB Cash: ',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: '\$${totalCash.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
