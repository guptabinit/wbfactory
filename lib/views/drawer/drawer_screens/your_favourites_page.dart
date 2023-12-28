import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';
import '../../../components/buttons/back_button.dart';
import '../../../components/cards/item_card.dart';
import '../../../constants/colors.dart';
import '../../../constants/consts.dart';
import '../../other_screens/product_detail_page.dart';

class YourFavouritesPage extends StatefulWidget {
  const YourFavouritesPage({super.key});

  @override
  State<YourFavouritesPage> createState() => _YourFavouritesPageState();
}

class _YourFavouritesPageState extends State<YourFavouritesPage> {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Favourites",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
            8.heightBox,
            const Text(
              "Here you can take look at all your favourite food items.",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: darkGreyColor,
              ),
            ),
            12.heightBox,
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: secondaryColor,
                    ),
                  );
                }

                if( snapshot.data!['favourite'].length > 0){
                  return Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1 / 1.16,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: snapshot.data!['favourite'].length,
                      itemBuilder: (BuildContext context, index) {
                        var snap = snapshot.data!['favourite'][index];

                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ProductDetailPage(snap: snap, userAvailable: true,));
                          },
                          child: ItemCard(
                            snap: snap,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(child: emptyFavourite());
                }

              },
            ),
          ],
        ),
      ),
    );
  }

  Widget emptyFavourite() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.network(
            'https://lottie.host/9e1ee185-6fd3-4cda-9c7a-a777e692c902/UkzWfUorMg.json',
            repeat: true,
            width: screenWidth(context) * 0.75,
          ),
          16.heightBox,
          const Text(
            "Add item in your favourite list",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: darkGreyColor,
            ),
          ),
          64.heightBox,
        ],
      ),
    );
  }

}
