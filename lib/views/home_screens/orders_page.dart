import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/components/cards/order_card.dart';
import '../../constants/colors.dart';
import '../onboarding_screens/login_page.dart';

class OrdersPage extends StatefulWidget {
  final bool userAvailable;
  const OrdersPage({super.key, required this.userAvailable});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.heightBox,
            const Text(
              "Your Orders",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
            8.heightBox,
            const Text(
              "Here you can take look at all your previous orders and also repeat the same previous order.",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: darkGreyColor,
              ),
            ),
            widget.userAvailable ? StreamBuilder(
              stream: FirebaseFirestore.instance.collection('allOrders').where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy('oid', descending: true).snapshots(),
              builder: (
                context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }

                if (snapshot.hasData) {
                  final orderLength = snapshot.data!.docs.length;

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
                      : Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(top: 12),
                            itemCount: orderLength,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              final snap = snapshot.data!.docs[index];
                        
                              return OrderCard(
                                snap: snap,
                              );
                            },
                          ),
                      );
                } else {
                  return Center(
                    child: Lottie.network(
                      'https://lottie.host/1c93e52f-afdd-4f2e-9697-d66e27256df4/5jlcTbp7Ss.json',
                      repeat: true,
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.width * 0.7,
                    ),
                  );
                }
              },
            ) : Padding(
              padding: const EdgeInsets.only(top: 24),
              child: MainButton(title: "Login/Signup to view more", onTap: (){ Get.offAll(() => const LoginPage()); }),
            ),
          ],
        ),
      ),
    );
  }
}
