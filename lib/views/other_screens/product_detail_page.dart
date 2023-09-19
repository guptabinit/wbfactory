import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart' as user_model;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/constants/consts.dart';
import 'package:wbfactory/resources/shop_methods.dart';

import '../../components/buttons/back_button.dart';
import '../../resources/auth_methods.dart';

class ProductDetailPage extends StatefulWidget {
  final snap;

  ProductDetailPage({super.key, required this.snap});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  TextEditingController searchController = TextEditingController();
  var selected = {};
  bool isFavourite = false;
  bool isLoading = false;

  getUserFavouriteData() async {
    var tempUser = await AuthMethods().getUserDetails();

    if(tempUser.favouriteList.contains(widget.snap['pid'])){
      setState(() {
        isFavourite = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    try{
      getUserFavouriteData();
    } catch (e) {
      print("Some error occurred while retrieving user's data");
    }
    try {
      selected = widget.snap['variantInfo'][0];
    } catch (e) {
      print("Error: No variant present.");
    }
  }

  showToast(String msg, Color color){
    return customToast(msg, greenColor, context);
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
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              if(isFavourite == false){
                // add to favourite
                String result = await ShopMethods().addFavourite(product: widget.snap, pid: widget.snap["pid"]);

                if (result == 'success') {
                  setState(() {
                    isFavourite = true;
                    isLoading = false;
                  });
                  showToast("Added to favourites", greenColor);
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  showToast("Some error occurred while adding this product to favourites", redColor);
                }
              } else {
                // remove from favourite
                String result = await ShopMethods().removeFavourite(product: widget.snap, pid: widget.snap["pid"]);

                if (result == 'success') {
                  setState(() {
                    isFavourite = false;
                    isLoading = false;
                  });
                  showToast("Removed from favourites", greenColor);
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  showToast("Some error occurred while removing this product from favourites", redColor);
                }
              }

            },
            icon: isLoading
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      color: secondaryColor,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border_outlined,
                    color: isFavourite ? redColor : secondaryColor,
                  ),
          ),
          4.widthBox,
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 3,
                        child: CachedNetworkImage(
                          imageUrl: widget.snap != null ? widget.snap["imageUrl"] : "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/products%2Fbagel.jpg?alt=media&token=6cc183bb-93ca-45f8-b7ef-b6be9fd3a75e",
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            16.heightBox,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.snap['itemName'],
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: darkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$ ${widget.snap['price'].toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            8.heightBox,
                            Text(
                              "Category: ${widget.snap['category']}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: secondaryColor,
                              ),
                            ),
                            12.heightBox,
                            const Divider(
                              color: darkGreyColor,
                              thickness: 1,
                            ),
                            8.heightBox,
                            const Text(
                              "VARIANTS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: darkColor,
                              ),
                            ),
                            16.heightBox,
                            widget.snap['haveVarient'] == false
                                ? const Text(
                                    "No such variants found",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: darkGreyColor,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: widget.snap['variantInfo'].map<Widget>(
                                      (item) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selected = item;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: selected == item ? secondaryColor.withOpacity(0.1) : Colors.transparent,
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(
                                                color: selected == item ? secondaryColor : darkGreyColor,
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                            margin: const EdgeInsets.only(bottom: 4),
                                            child: Row(
                                              children: [
                                                Expanded(child: Text("${item['variantName']}")),
                                                8.widthBox,
                                                Text(
                                                  "+ \$ ${item['variantPrice'].toStringAsFixed(2)}",
                                                  style: const TextStyle(
                                                    color: secondaryColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                            86.heightBox,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 12,
            right: 12,
            child: MainButton(
              title: "Add to cart",
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
