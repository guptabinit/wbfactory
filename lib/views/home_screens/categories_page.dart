import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';
import '../other_screens/search_screen.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
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
            16.heightBox,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Explore all categories",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: darkColor,
                ),
              ),
            ),
            8.heightBox,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                childAspectRatio: 1 / 1.2,
                mainAxisSpacing: 12,
              ),
              padding: const EdgeInsets.all(12),
              itemCount: 12,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: itemWidget(),
                );
              },
            ),
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
