import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/cards/item_card.dart';
import 'package:wbfactory/components/textfield/custom_textfield.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/other_screens/product_detail_page.dart';

import '../../components/buttons/back_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  bool isShowItem = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    controller: searchController,
                    onEditingCompleted: () {
                      setState(() {
                        isShowItem = true;
                      });
                    },
                    title: "Search",
                    hintText: "Search anything...",
                  ),
                ),
                8.widthBox,
                Material(
                  borderRadius: BorderRadius.circular(8),
                  color: secondaryColor,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      setState(() {
                        isShowItem = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        CupertinoIcons.search,
                        color: lightColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            12.heightBox,
            isShowItem
                ? FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('products')
                        .where(
                          'itemName',
                          isGreaterThanOrEqualTo: searchController.text.toUpperCase(),
                        ).get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: secondaryColor,
                            ),
                          ),
                        );
                      }
                      return Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Based on your search we have ",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: darkColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${snapshot.data!.docs.length} products",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              16.heightBox,
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 1 / 1.16,
                                  mainAxisSpacing: 12,
                                ),
                                itemCount: (snapshot.data! as dynamic).docs.length,
                                itemBuilder: (BuildContext context, index) {
                                  var snap = snapshot.data!.docs[index].data();

                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => ProductDetailPage(snap: snap));
                                    },
                                    child: ItemCard(
                                      snap: snap,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const Expanded(
                    child: Center(
                      child: Text("Search Something..."),
                    ),
                  ),
            Container(),
          ],
        ),
      ),
    );
  }

// Widget itemCard() {
//   return Column(
//     children: [
//       ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(8),
//           topRight: Radius.circular(8),
//         ),
//         child: Container(
//           color: lightGreyColor,
//           child: Stack(
//             children: [
//               AspectRatio(
//                 aspectRatio: 4 / 3,
//                 child: CachedNetworkImage(
//                   imageUrl: "https://www.fbgcdn.com/pictures/70975afb-496e-4002-ab2e-c0077933e936.jpg",
//                   fit: BoxFit.cover,
//                   progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
//                   errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
//                   width: double.infinity,
//                 ),
//               ),
//               Positioned(
//                 bottom: 8,
//                 right: 8,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
//                   decoration: BoxDecoration(
//                     color: secondaryColor,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: const Text(
//                     "\$ 7.99",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: lightColor,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       Container(
//         padding: const EdgeInsets.all(12),
//         decoration: const BoxDecoration(
//           color: veryLightGreyColor,
//           borderRadius: BorderRadius.only(
//             bottomRight: Radius.circular(8),
//             bottomLeft: Radius.circular(8),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               "Food Name",
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: darkColor,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             4.heightBox,
//             const Text(
//               "Category",
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: 11,
//                 color: darkGreyColor,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//       )
//     ],
//   );
// }
}
