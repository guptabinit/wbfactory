import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/models/category.dart';

import '../../constants/colors.dart';
import '../other_screens/product_page.dart';
import '../other_screens/search_screen.dart';

class CategoriesPage extends StatefulWidget {
  final bool userAvailable;

  const CategoriesPage({super.key, required this.userAvailable});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  Stream<List<Category>> get _categories => FirebaseFirestore.instance
      .collection('categories')
      .orderBy('category', descending: false)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => Category.fromJson(
                doc.data(),
              ),
            )
            .toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
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
            StreamBuilder(
                stream: _categories,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Something went wrong!',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        );
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1 / 1.32,
                          mainAxisSpacing: 12,
                        ),
                        padding: const EdgeInsets.all(12),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final category = snapshot.data?.elementAt(index);
                          return itemWidget(
                            category!.thumbnail!,
                            category.name!,
                          );
                        },
                      );
                  }
                }),
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
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
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
