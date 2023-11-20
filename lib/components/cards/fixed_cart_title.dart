import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';

class FixedCartTile extends StatefulWidget {
  final dynamic itemSnap;
  const FixedCartTile({super.key, required this.itemSnap});

  @override
  State<FixedCartTile> createState() => _FixedCartTileState();
}

class _FixedCartTileState extends State<FixedCartTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: lightColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 100,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          imageUrl: widget.itemSnap['item_image'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  12.widthBox,
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                widget.itemSnap["item_name"],
                                 overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                ),
                              ),
                              4.heightBox,
                               Text(
                                 widget.itemSnap["category"],
                                 overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: darkGreyColor,
                                ),
                              ),
                            ],
                          ),
                           Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "\$ ${widget.itemSnap["total_price"].toDouble().toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                ),
                              ),
                              Text(
                                " • Qty: ${widget.itemSnap["quantity"]}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: darkGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              6.heightBox,
              Text(
                widget.itemSnap["haveVarient"] ? "Varient: ${widget.itemSnap["selectedVarient"]} (\$ ${widget.itemSnap["selectedVarientPrice"].toDouble().toStringAsFixed(2)})" : "Varient: No Variants Chosen.",
                style: const TextStyle(
                  color: darkGreyColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: lightGreyColor,
          height: 1,
        )
      ],
    );
  }
}
