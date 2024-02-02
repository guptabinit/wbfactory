import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/cards/item_card.dart';
import 'package:wbfactory/components/textfield/custom_textfield.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/order_screens/order_palaced_screens/new_order_placed_screen.dart';
import 'package:wbfactory/views/order_screens/order_palaced_screens/order_waiting_screen.dart';
import 'package:wbfactory/views/order_screens/order_palaced_screens/some_error_screen.dart';
import 'package:wbfactory/views/other_screens/product_detail_page.dart';

import '../../components/buttons/back_button.dart';

class SearchScreen extends StatefulWidget {
  final bool userAvailable;
  const SearchScreen({super.key, required this.userAvailable});

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

  bool isLoading = false;

  Future<void> updateAllDocuments() async {

    setState(() {
      isLoading = true;
    });
    try {

    List<String> bannerLinksList = [
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F1.png?alt=media&token=736244b2-6aab-44b5-b7b0-100848cca7c6",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F12.png?alt=media&token=b9d7692b-2c78-45a0-86a8-c687ca3d4e82",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F13.png?alt=media&token=3d2ac6e7-c966-41cf-95bf-63baa77c75a6",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F17.png?alt=media&token=32311171-efb9-4193-9018-0a2a3d7d5d4d",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F18.png?alt=media&token=142d3b33-675d-4423-93aa-a711b0dd8600",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F19.png?alt=media&token=65e9c6a3-e64c-4415-8897-79040675ddd6",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F2.png?alt=media&token=c0ec93c8-3302-4d59-b1c1-08f8e1e6f07e",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F20.png?alt=media&token=7ef1bc87-ea6f-4e0f-901e-3f3dd9ea9345",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F21.png?alt=media&token=191bd1af-cc8f-448f-a4b4-c1f617df078a",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F23.png?alt=media&token=38097785-dc88-4b4c-bd78-bbe273932e25",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F24.png?alt=media&token=b5b9eec2-c02a-4f6e-a96c-b2b877c3967d",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F25.png?alt=media&token=2f5c8d1f-a93d-4a36-ac36-00d9e874d8cf",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F27.png?alt=media&token=dc12c984-fa57-4bba-bdd3-6dfff500fc19",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F28.png?alt=media&token=4d47601c-f98c-47b6-9525-a0625b41be51",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F29.png?alt=media&token=038ca98c-c646-436a-b5c6-3fd9c1c04615",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F3.png?alt=media&token=658674c0-06cd-414a-a039-0d57378ddd39",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F31.png?alt=media&token=116b7959-5f35-4a22-a029-b6eb5531473a",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F32.png?alt=media&token=f3eb973b-b25c-4ba9-92ec-c1a702b2b4ca",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F4.png?alt=media&token=17512af8-0738-4d26-9200-a5f038e427b1",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F5.png?alt=media&token=90626a95-ad6e-4ec9-9095-4a47f2b83a53",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F6.png?alt=media&token=8299170b-534f-49b8-a846-e7c0648b2b1f",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F7.png?alt=media&token=c9df5642-e0a5-44dc-ae77-366fd66f7ee1",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F8.png?alt=media&token=75928d58-17bf-4d2a-99e2-bd06c11ca7a8",
    "https://firebasestorage.googleapis.com/v0/b/whitestone-bagel-factory.appspot.com/o/banners%2F9.png?alt=media&token=9768879e-c008-4d89-8de1-d45e8a51cd8d",
    ];


    List<Map<String, String>> bannerList = bannerLinksList
          .map((link) => {'image_path': link})
          .toList();

    CollectionReference commonsCollection = FirebaseFirestore.instance.collection('commons');

    await commonsCollection.doc('banners').set({'banner_links': bannerList});

    print("Done Successfully");
    } catch (e) {
      print('Error updating documents: $e');
    }

    setState(() {
      isLoading = false;
    });
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
        // actions: [
        //   isLoading ? CircularProgressIndicator() : IconButton(
        //     onPressed: () {
        //       updateAllDocuments();
        //
        //       print("Hello");
        //     },
        //     tooltip: "Test",
        //     icon: const Icon(
        //       Icons.warning_amber,
        //       color: secondaryColor,
        //     ),
        //   ),
        //   8.widthBox,
        // ],
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
                                      Get.to(() => ProductDetailPage(snap: snap, userAvailable: widget.userAvailable,));
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
