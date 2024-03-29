import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/constants/consts.dart';
import 'package:wbfactory/views/other_screens/product_detail_page.dart';

import '../../components/buttons/back_button.dart';
import '../../components/cards/item_card.dart';
import 'cart_page.dart';

class ProductPage extends StatefulWidget {
  final String title;
  final bool userAvailable;

  const ProductPage({
    super.key,
    required this.title,
    required this.userAvailable,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController searchController = TextEditingController();

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                widget.userAvailable ? Get.to(() => const CartPage()) : showLoginDialog(context);
              },
              icon: const Icon(
                CupertinoIcons.shopping_cart,
                color: secondaryColor,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').where('category', isEqualTo: widget.title).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: darkColor,
                  ),
                ),
                12.heightBox,
                Row(
                  children: [
                    const Text(
                      "We have ",
                      style: TextStyle(
                        fontSize: 13,
                        color: darkColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${snapshot.data!.docs.length} products ",
                      style: const TextStyle(
                        fontSize: 13,
                        color: secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      "in this category",
                      style: TextStyle(
                        fontSize: 13,
                        color: darkColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                12.heightBox,
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1 / 1.16,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, index) {
                      var snap = snapshot.data!.docs[index].data();

                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ProductDetailPage(snap: snap, userAvailable: widget.userAvailable,));
                        },
                        child: ItemCard(
                          snap: snap,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
