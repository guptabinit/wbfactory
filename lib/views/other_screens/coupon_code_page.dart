import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../components/buttons/back_button.dart';
import '../../components/cards/promotional_card.dart';
import '../../constants/colors.dart';

class CouponCodePage extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  final List<dynamic> usedCoupons;

  const CouponCodePage(
      {super.key, required this.data, required this.usedCoupons});

  @override
  State<CouponCodePage> createState() => _CouponCodePageState();
}

class _CouponCodePageState extends State<CouponCodePage> {
  List realCouponList = [];

  @override
  void initState() {
    try {
      setState(() {
        realCouponList = widget.data['code_list']
            .where((element) => !widget.usedCoupons.contains(element))
            .toList();
      });
    } catch (e) {
      if (kDebugMode) {
        print("No Coupons");
      }
    }

    super.initState();
  }

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
              realCouponList.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.network(
                          'https://lottie.host/1c93e52f-afdd-4f2e-9697-d66e27256df4/5jlcTbp7Ss.json',
                          repeat: true,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.width * 0.7,
                        ),
                        const Text(
                          "Sorry! No Offers Present",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 12),
                      itemCount: realCouponList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        var couponSnap = widget.data[realCouponList[index]];

                        return PromotionalCard(
                          snap: couponSnap,
                          couponPage: true,
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
