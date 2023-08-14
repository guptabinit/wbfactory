import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';

class ItemCard extends StatefulWidget {
  final snap;
  const ItemCard({super.key, this.snap});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: Container(
            color: lightGreyColor,
            child: Stack(
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
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.snap != null ? "\$ ${widget.snap["price"].toStringAsFixed(2)}" :"\$ 7.99",
                      style: const TextStyle(
                        fontSize: 14,
                        color: lightColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: veryLightGreyColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.snap != null ? "${widget.snap["itemName"]}" :"Food Name",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: darkColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              4.heightBox,
              Text(
                widget.snap != null ? "${widget.snap["category"]}" : "Category",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: darkGreyColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
