import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/textfield/custom_textfield.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/home_screens/main_nav_page.dart';
import 'package:wbfactory/views/other_screens/search_screen.dart';

import '../../constants/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            8.heightBox,
            GestureDetector(
              onTap: () {
                Get.to(() => const SearchScreen());
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
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
              height: 160,
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(8),
              ),
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
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
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
                        onTap: () {},
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
                    physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                    child: Row(
                      children: [
                        itemWidget(),
                        12.widthBox,
                        itemWidget(),
                        12.widthBox,
                        itemWidget(),
                        12.widthBox,
                        itemWidget(),
                        12.widthBox,
                        itemWidget(),
                        12.widthBox,
                        itemWidget(),
                      ],
                    ),
                  ),
                ],
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
                          padding: const EdgeInsets.symmetric(vertical: 4),
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
                    physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                    child: Row(
                      children: [
                        itemWidget(),
                        12.widthBox,
                        itemWidget(),
                        12.widthBox,
                        itemWidget(),
                        12.widthBox,
                        itemWidget(),
                        12.widthBox,
                        itemWidget(),
                        12.widthBox,
                        itemWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            16.heightBox,
          ],
        ),
      ),
    );
  }

  Widget itemWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            color: lightGreyColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        8.heightBox,
        const Text(
          "Category Name",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: darkColor,
          ),
        ),
      ],
    );
  }
}
