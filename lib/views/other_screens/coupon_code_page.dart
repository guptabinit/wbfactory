import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../components/buttons/back_button.dart';
import '../../components/cards/promotional_card.dart';
import '../../constants/colors.dart';

class CouponCodePage extends StatefulWidget {
  const CouponCodePage({super.key});

  @override
  State<CouponCodePage> createState() => _CouponCodePageState();
}

class _CouponCodePageState extends State<CouponCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: backButton(
          onTap: () {
            Get.back();
          },
        ),
        leadingWidth: 90,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Promotional Offers",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: darkColor,
                ),
              ),
              8.heightBox,
              const Text(
                "Here you can take look at all your coupon codes and promotional offers.",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: darkGreyColor,
                ),
              ),
              8.heightBox,
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('commons').doc("coupons").snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  var snap = snapshot.data!;
                  var orderLength = snap['cList'].length;

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
                            var mainSnap = snap['cList'][index];

                            return PromotionalCard(snap: mainSnap);
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
