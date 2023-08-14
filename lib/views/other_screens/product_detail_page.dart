import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';

import '../../components/buttons/back_button.dart';

class ProductDetailPage extends StatefulWidget {
  final snap;

  const ProductDetailPage({super.key, required this.snap});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  TextEditingController searchController = TextEditingController();

  List<bool> selections = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      setState(() {
        selections = List.generate(widget.snap['variantInfo'].length, (_) => false);
      });
    } catch (e) {
      print("Error: variant unavailable");
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: backButton(),
        ),
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
                                : ToggleButtons(
                                    children: widget.snap['variantInfo']
                                        .map<Widget>(
                                          (item) => Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            child: Row(
                                              children: [
                                                Expanded(child: Text("${item['variantName']}")),
                                                8.widthBox,
                                                Text(
                                                  "\$ ${item['variantPrice'].toStringAsFixed(2)}",
                                                  style: const TextStyle(
                                                    color: secondaryColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    selectedBorderColor: secondaryColor,
                                    direction: Axis.vertical,
                                    isSelected: selections,
                                    onPressed: (int index) {
                                      setState(() {
                                        selections[index] = !selections[index];
                                      });
                                    },
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
