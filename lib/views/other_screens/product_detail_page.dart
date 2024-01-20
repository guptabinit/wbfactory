import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  final dynamic snap;
  final bool userAvailable;

  const ProductDetailPage(
      {super.key, required this.snap, required this.userAvailable});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController specialInstructionController = TextEditingController();
  bool isFavourite = false;
  bool isLoading = false;
  var cartData = {};

  // String? selectedVarient;
  // double selectedVarientPrice = 0.00;
  List<bool?> selectedVarientList = [];

  String? selectedQuantity;
  double selectedQuantityPrice = 0.00;

  getUserCartData() async {
    try {
      var cartSnap = await FirebaseFirestore.instance
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      cartData = cartSnap.data()!;
      setState(() {});
    } catch (e) {}
  }

  getUserFavoriteData() async {
    var tempUser = await AuthMethods().getUserDetails();

    if (tempUser.favouriteList.contains(widget.snap['pid'])) {
      setState(() {
        isFavourite = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.userAvailable) {
      try {
        getUserCartData();
      } catch (e) {
        if (kDebugMode) {
          print(
              "Some error occurred while retrieving user's data: ${e.toString()}");
        }
      }

      try {
        getUserFavoriteData();
      } catch (e) {
        if (kDebugMode) {
          print(
              "Some error occurred while retrieving user's data: ${e.toString()}");
        }
      }
    }

    if (widget.snap["haveVarient"]) {
      for (int i = 0; i < widget.snap["variantInfo"].length; i++) {
        selectedVarientList.add(false);
      }
    }
  }

  showCustomToast(String msg, Color color) {
    return customToast(msg, color, context);
  }

  void addToCart() async {
    if (widget.snap["haveVarient"] == true &&
        widget.snap["isQuantity"] == false) {
      setState(() {
        isLoading = true;
      });

      List<String> selectedVarientNames = [];
      List<double> selectedVarientAlternatePrices = [];
      double totalVarientPrice = 0.00;

      if (widget.snap['haveVarient']) {
        for (int i = 0; i < widget.snap['variantInfo'].length; i++) {
          if (selectedVarientList[i] == true) {
            selectedVarientNames
                .add(widget.snap['variantInfo'][i]['variantName']);
            selectedVarientAlternatePrices
                .add(widget.snap['variantInfo'][i]['variantPrice'].toDouble());
            setState(() {
              totalVarientPrice = totalVarientPrice +
                  widget.snap['variantInfo'][i]['variantPrice'].toDouble();
            });
          }
        }
      }

      double packagePrice = widget.snap["price"].toDouble() + totalVarientPrice;

      double cartAmount = (cartData["cart_amount"] ?? 0) + packagePrice;

      String message = await ShopMethods().addToCart(
        pid: widget.snap["pid"],
        itemName: widget.snap["itemName"],
        quantity: 1,
        itemPrice: widget.snap["price"],
        packagePrice: packagePrice,
        totalPrice: packagePrice,
        category: widget.snap["category"],
        itemImage: widget.snap["imageUrl"],
        selectedVarient: selectedVarientNames,
        haveVarient: widget.snap["haveVarient"],
        selectedVarientPrice: selectedVarientAlternatePrices,
        context: context,
        cartAmount: cartAmount,
        isQuantity: widget.snap["isQuantity"],
        selectedQuantity: selectedQuantity,
        selectedQuantityPrice: selectedQuantityPrice,
        specialInstruction: specialInstructionController.text,
      );

      if (message == 'success') {
        setState(() {
          isLoading = false;
        });
        showCustomToast("Item added successfully", greenColor);
        Get.back();
      } else {
        setState(() {
          isLoading = false;
        });
        showCustomToast("Error: $message", darkGreyColor);
      }
    } else if (widget.snap["haveVarient"] == false &&
        widget.snap["isQuantity"] == true) {
      if (selectedQuantity == null) {
        showCustomToast("Select all the choice first", darkGreyColor);
      } else {
        setState(() {
          isLoading = true;
        });

        double packagePrice =
            widget.snap["price"].toDouble() + selectedQuantityPrice;

        double cartAmount = (cartData["cart_amount"] ?? 0 )+ packagePrice;

        String message = await ShopMethods().addToCart(
          pid: widget.snap["pid"],
          itemName: widget.snap["itemName"],
          quantity: 1,
          itemPrice: widget.snap["price"],
          packagePrice: packagePrice,
          totalPrice: packagePrice,
          category: widget.snap["category"],
          itemImage: widget.snap["imageUrl"],
          selectedVarient: [],
          haveVarient: widget.snap["haveVarient"],
          selectedVarientPrice: [],
          context: context,
          cartAmount: cartAmount,
          isQuantity: widget.snap["isQuantity"],
          selectedQuantity: selectedQuantity,
          selectedQuantityPrice: selectedQuantityPrice,
          specialInstruction: specialInstructionController.text,
        );

        if (message == 'success') {
          setState(() {
            isLoading = false;
          });
          showCustomToast("Item added successfully", greenColor);
          Get.back();
        } else {
          setState(() {
            isLoading = false;
          });
          showCustomToast("Error: $message", darkGreyColor);
        }
      }
    } else if (widget.snap["haveVarient"] == true &&
        widget.snap["isQuantity"] == true) {
      // when there exist both
      if (selectedQuantity == null) {
        showCustomToast("Select all the choices first", darkGreyColor);
      } else {
        setState(() {
          isLoading = true;
        });

        List<String> selectedVarientNames = [];
        List<double> selectedVarientAlternatePrices = [];
        double totalVarientPrice = 0.00;

        if (widget.snap['haveVarient']) {
          for (int i = 0; i < widget.snap['variantInfo'].length; i++) {
            if (selectedVarientList[i] == true) {
              selectedVarientNames
                  .add(widget.snap['variantInfo'][i]['variantName']);
              selectedVarientAlternatePrices.add(
                  widget.snap['variantInfo'][i]['variantPrice'].toDouble());
              setState(() {
                totalVarientPrice = totalVarientPrice +
                    widget.snap['variantInfo'][i]['variantPrice'].toDouble();
              });
            }
          }
        }

        double packagePrice = widget.snap["price"].toDouble() +
            selectedQuantityPrice +
            totalVarientPrice;

        double cartAmount = (cartData["cart_amount"]  ?? 0 ) + packagePrice;

        String message = await ShopMethods().addToCart(
          pid: widget.snap["pid"],
          itemName: widget.snap["itemName"],
          quantity: 1,
          itemPrice: widget.snap["price"],
          packagePrice: packagePrice,
          totalPrice: packagePrice,
          category: widget.snap["category"],
          itemImage: widget.snap["imageUrl"],
          selectedVarient: selectedVarientNames,
          haveVarient: widget.snap["haveVarient"],
          selectedVarientPrice: selectedVarientAlternatePrices,
          context: context,
          cartAmount: cartAmount,
          isQuantity: widget.snap["isQuantity"],
          selectedQuantity: selectedQuantity,
          selectedQuantityPrice: selectedQuantityPrice,
          specialInstruction: specialInstructionController.text,
        );

        if (message == 'success') {
          setState(() {
            isLoading = false;
          });
          showCustomToast("Item added successfully", greenColor);
          Get.back();
        } else {
          setState(() {
            isLoading = false;
          });
          showCustomToast("Error: $message", darkGreyColor);
        }
      }
    } else {
      setState(() {
        isLoading = true;
      });

      double packagePrice = widget.snap["price"].toDouble();

      double cartAmount = (cartData["cart_amount"] ?? 0)+ packagePrice;

      String message = await ShopMethods().addToCart(
        pid: widget.snap["pid"],
        itemName: widget.snap["itemName"],
        quantity: 1,
        itemPrice: widget.snap["price"],
        packagePrice: packagePrice,
        category: widget.snap["category"],
        totalPrice: packagePrice,
        itemImage: widget.snap["imageUrl"],
        selectedVarient: [],
        haveVarient: widget.snap["haveVarient"],
        selectedVarientPrice: [],
        context: context,
        cartAmount: cartAmount,
        isQuantity: widget.snap["isQuantity"],
        selectedQuantity: selectedQuantity,
        selectedQuantityPrice: selectedQuantityPrice,
        specialInstruction: specialInstructionController.text,
      );

      if (message == 'success') {
        setState(() {
          isLoading = false;
        });
        showCustomToast("Item added successfully", greenColor);
        Get.back();
      } else {
        setState(() {
          isLoading = false;
        });
        showCustomToast("Error: $message", darkGreyColor);
      }
    }
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
          !widget.userAvailable
              ? Container()
              : IconButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    if (isFavourite == false) {
                      // add to favourite
                      String result = await ShopMethods().addFavourite(
                          product: widget.snap, pid: widget.snap["pid"]);

                      if (result == 'success') {
                        setState(() {
                          isFavourite = true;
                          isLoading = false;
                        });
                        showCustomToast("Added to favourites", greenColor);
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        showCustomToast(
                            "Some error occurred while adding this product to favourites",
                            redColor);
                      }
                    } else {
                      // remove from favourite
                      String result = await ShopMethods().removeFavourite(
                          product: widget.snap, pid: widget.snap["pid"]);

                      if (result == 'success') {
                        setState(() {
                          isFavourite = false;
                          isLoading = false;
                        });
                        showCustomToast("Removed from favourites", greenColor);
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        showCustomToast(
                            "Some error occurred while removing this product from favourites",
                            redColor);
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
                          isFavourite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
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
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 3,
                        child: CachedNetworkImage(
                          imageUrl: widget.snap != null
                              ? widget.snap["imageUrl"]
                              : "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/products%2Fbagel.jpg?alt=media&token=6cc183bb-93ca-45f8-b7ef-b6be9fd3a75e",
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress)),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
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
                            widget.snap['haveDesc'] ? 8.heightBox : Container(),
                            widget.snap['haveDesc']
                                ? const Divider(
                                    color: darkGreyColor,
                                    thickness: 1,
                                  )
                                : Container(),
                            8.heightBox,
                            widget.snap['haveDesc']
                                ? const Text(
                                    "Description & Ingredient:",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: darkColor,
                                    ),
                                  )
                                : Container(),
                            8.heightBox,
                            widget.snap['haveDesc']
                                ? Text(
                                    "${widget.snap['description']}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: darkGreyColor,
                                    ),
                                  )
                                : Container(),
                            widget.snap['haveDesc']
                                ? 12.heightBox
                                : Container(),
                            widget.snap['haveVarient']
                                ? const Divider(
                                    color: darkGreyColor,
                                    thickness: 1,
                                  )
                                : Container(),
                            widget.snap['haveVarient']
                                ? 8.heightBox
                                : Container(),
                            widget.snap['haveVarient']
                                ? const Text(
                                    "Choose a varient",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: darkColor,
                                    ),
                                  )
                                : Container(),
                            widget.snap['haveVarient']
                                ? 12.heightBox
                                : Container(),
                            widget.snap['haveVarient']
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        widget.snap["variantInfo"].length,
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, index) {
                                      var docSnap =
                                          widget.snap["variantInfo"][index];

                                      return CheckboxListTile(
                                        title: Text(docSnap['variantName']),
                                        subtitle: Text(
                                            "Price: +\$ ${docSnap['variantPrice'].toDouble().toStringAsFixed(2)}"),
                                        value: selectedVarientList[index],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedVarientList[index] = value;
                                          });
                                        },
                                      );
                                    },
                                  )
                                : Container(),
                            widget.snap['isQuantity']
                                ? 8.heightBox
                                : Container(),
                            widget.snap['isQuantity']
                                ? const Divider(
                                    color: darkGreyColor,
                                    thickness: 1,
                                  )
                                : Container(),
                            8.heightBox,
                            widget.snap['isQuantity']
                                ? const Text(
                                    "Choose your choice",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: darkColor,
                                    ),
                                  )
                                : Container(),
                            widget.snap['isQuantity']
                                ? 12.heightBox
                                : Container(),
                            widget.snap['isQuantity']
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        widget.snap["quantityInfo"].length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(0),
                                    itemBuilder: (BuildContext context, index) {
                                      var docSnap =
                                          widget.snap["quantityInfo"][index];

                                      return RadioListTile<String>(
                                        title: Text(docSnap['quantityName']),
                                        subtitle: Text(
                                            "Price: +\$ ${docSnap['quantityPrice'].toDouble().toStringAsFixed(2)}"),
                                        value: docSnap['quantityName'],
                                        groupValue: selectedQuantity,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedQuantity = value;
                                            selectedQuantityPrice =
                                                docSnap['quantityPrice']
                                                    .toDouble();
                                          });
                                        },
                                      );
                                    },
                                  )
                                : Container(),
                            // Divider
                            const Divider(
                              color: darkGreyColor,
                              thickness: 1,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                bottom: 16,
                              ),
                              child: Column(
                                children: [
                                  8.heightBox,
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Special Instruction (if any)",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: darkColor,
                                          ),
                                        ),
                                      ),
                                      0.widthBox,
                                    ],
                                  ),
                                  8.heightBox,
                                  Container(
                                    decoration: BoxDecoration(
                                      color: veryLightGreyColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: TextField(
                                      controller: specialInstructionController,
                                      maxLines: 3,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 16,
                                          horizontal: 12,
                                        ),
                                        isDense: true,
                                        fillColor: veryLightGreyColor,
                                        hintText:
                                            "Enter your special instruction here",
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: darkGreyColor,
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : MainButton(
                    title: "Add to cart",
                    onTap: !widget.userAvailable
                        ? () {
                            showLoginDialog(context);
                          }
                        : addToCart,
                  ),
          ),
        ],
      ),
    );
  }
}
