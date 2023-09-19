import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/constants/consts.dart';

import '../../constants/colors.dart';
import '../../models/user_model.dart' as user_model;
import '../../resources/auth_methods.dart';

class OffersPage extends StatefulWidget {

  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {

  user_model.User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      getUserData();
    } catch (e) {
      print("Error while fetching user");
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
        physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                    Expanded(
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
                    ),
                    Container(),
                  ],
                ),
              ),
              12.heightBox,
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    4.heightBox,
                    const Text(
                      "Promotional Offers",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: darkColor,
                      ),
                    ),
                    12.heightBox,
                    promotionCard(context),
                    12.heightBox,
                    promotionCard(context),
                    12.heightBox,
                    promotionCard(context),
                    12.heightBox,
                    promotionCard(context),
                    12.heightBox,
                    promotionCard(context),
                    12.heightBox,
                    promotionCard(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget promotionCard(context) {
    return Container(
      decoration: BoxDecoration(
        color: veryLightGreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl: "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/categories%2Ffrom_our_grill.jpg?alt=media&token=a535b8f0-79bd-450f-8d09-5e6d42218a58",
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Container(
            width: screenWidth(context) * 0.6,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            decoration: const BoxDecoration(
              color: veryLightGreyColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "15% off on your first order",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: darkColor,
                  ),
                ),
                4.heightBox,
                const Row(
                  children: [
                    Text(
                      "Apply code: ",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: darkGreyColor,
                      ),
                    ),
                    Text(
                      "FIRST15",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
                8.heightBox,
                Material(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      customToast("Code copied successfully", secondaryColor, context);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: secondaryColor),
                      ),
                      child: const Text(
                        "COPY",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
