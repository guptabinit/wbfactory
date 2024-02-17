import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/home_screens/main_nav_page.dart';
import 'package:wbfactory/views/other_screens/search_screen.dart';

import '../../data/categories.dart';
import '../other_screens/product_page.dart';

class HomePage extends StatefulWidget {
  final bool userAvailable;

  const HomePage({super.key, required this.userAvailable});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List imageList = [
    {
      // "id": 1,
      "image_path":
          'https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F32.png?alt=media&token=f3eb973b-b25c-4ba9-92ec-c1a702b2b4ca'
    },
    {
      // "id": 2,
      "image_path":
          'https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F17.png?alt=media&token=32311171-efb9-4193-9018-0a2a3d7d5d4d'
    },
    {
      // "id": 3,
      "image_path":
          'https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F2.png?alt=media&token=c0ec93c8-3302-4d59-b1c1-08f8e1e6f07e'
    },
    {
      // "id": 4,
      "image_path":
          'https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F23.png?alt=media&token=38097785-dc88-4b4c-bd78-bbe273932e25'
    },
  ];

  @override
  void initState() {
    getData();

    super.initState();
  }

  getData() async {
    try {
      var snap = await FirebaseFirestore.instance
          .collection('commons')
          .doc('banners')
          .get();

      setState(() {
        imageList = snap.data()!['banner_links'];
      });
    } catch (e) {
      print("ERROR: Error in fetching");
    }
  }

  bool showDeals = false;

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            8.heightBox,
            GestureDetector(
              onTap: () {
                Get.to(() => SearchScreen(
                      userAvailable: widget.userAvailable,
                    ));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                decoration: BoxDecoration(
                  color: veryLightGreyColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Search anything...',
                      style: TextStyle(
                        color: darkGreyColor,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(child: Container()),
                    const Icon(
                      CupertinoIcons.search,
                      color: darkGreyColor,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
            12.heightBox,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: veryLightGreyColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CarouselSlider(
                    items: imageList
                        .map(
                          (item) => CachedNetworkImage(
                            imageUrl: item["image_path"],
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                            width: double.infinity,
                          ),
                        )
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            12.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.asMap().entries.map((entry) {
                return GestureDetector(
                    onTap: () => carouselController.animateToPage(entry.key),
                    child: Container(
                      width: currentIndex == entry.key ? 17 : 7,
                      height: 7.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentIndex == entry.key
                            ? secondaryColor
                            : lightGreyColor,
                      ),
                    ));
              }).toList(),
            ),
            16.heightBox,
            GestureDetector(
              onTap: () {
                Get.offAll(
                  () => const NavScreen(
                    currentIndex: 3,
                  ),
                  popGesture: false,
                  transition: Transition.noTransition,
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(
                  //   color: lightGreyColor,
                  //   width: 0.5,
                  // ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 12),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                    border: Border.all(
                      color: lightGreyColor,
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      12.widthBox,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Earn more and more rewards",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: darkColor,
                              ),
                            ),
                            2.heightBox,
                            const Text(
                              "Every time you order something on WB Factory App",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: darkGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      8.widthBox,
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: darkColor,
                        size: 22,
                      ),
                      8.widthBox,
                    ],
                  ),
                ),
              ),
            ),
            16.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Menu",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: darkColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(
                            () => const NavScreen(
                              currentIndex: 1,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              const Text(
                                "Full menu",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryColor,
                                ),
                              ),
                              6.widthBox,
                              const Icon(
                                Icons.arrow_forward,
                                color: secondaryColor,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  12.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.fast),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categories
                          .map(
                            (item) => Container(
                              margin: const EdgeInsets.only(right: 12),
                              child: itemWidget(
                                item['image_path'],
                                item['name'],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            showDeals
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Deals",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: darkColor,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    const Text(
                                      "View all",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    6.widthBox,
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: secondaryColor,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        12.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(
                              decelerationRate: ScrollDecelerationRate.fast),
                          child: Row(
                            children: [
                              itemWidget(
                                  "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/categories%2Fsandwiches.jpg?alt=media&token=3354a79b-0d71-4b9c-8713-0fdf2be8d43b",
                                  "Category Name"),
                              12.widthBox,
                              itemWidget(
                                  "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/categories%2Fsandwiches.jpg?alt=media&token=3354a79b-0d71-4b9c-8713-0fdf2be8d43b",
                                  "Category Name"),
                              12.widthBox,
                              itemWidget(
                                  "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/categories%2Fsandwiches.jpg?alt=media&token=3354a79b-0d71-4b9c-8713-0fdf2be8d43b",
                                  "Category Name"),
                              12.widthBox,
                              itemWidget(
                                  "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/categories%2Fsandwiches.jpg?alt=media&token=3354a79b-0d71-4b9c-8713-0fdf2be8d43b",
                                  "Category Name"),
                              12.widthBox,
                              itemWidget(
                                  "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/categories%2Fsandwiches.jpg?alt=media&token=3354a79b-0d71-4b9c-8713-0fdf2be8d43b",
                                  "Category Name"),
                              12.widthBox,
                              itemWidget(
                                  "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/categories%2Fsandwiches.jpg?alt=media&token=3354a79b-0d71-4b9c-8713-0fdf2be8d43b",
                                  "Category Name"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            16.heightBox,
          ],
        ),
      ),
    );
  }

  Widget itemWidget(String imgUrl, String title) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductPage(
              title: title,
              userAvailable: widget.userAvailable,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          8.heightBox,
          SizedBox(
            width: 160,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
