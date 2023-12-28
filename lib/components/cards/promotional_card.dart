import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/constants/consts.dart';

import '../../constants/colors.dart';
import '../../resources/shop_methods.dart';

class PromotionalCard extends StatefulWidget {
  final dynamic snap;
  final bool couponPage;

  const PromotionalCard({super.key, this.snap, required this.couponPage});

  @override
  State<PromotionalCard> createState() => _PromotionalCardState();
}

class _PromotionalCardState extends State<PromotionalCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: veryLightGreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.snap['image'],
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Container(
            width: screenWidth(context) * 0.7,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            decoration: const BoxDecoration(
              color: veryLightGreyColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.snap['coupon_name'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: darkColor,
                  ),
                ),
                4.heightBox,
                Row(
                  children: [
                    const Text(
                      "Apply code: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: darkGreyColor,
                      ),
                    ),
                    Text(
                      widget.snap['cid'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
                widget.couponPage ? Container() : 4.heightBox,
                widget.couponPage ? Container() : SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.0506,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.snap['coupon_desc'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: darkGreyColor,
                      ),
                    ),
                  ),
                ),
                widget.couponPage ? 8.heightBox : Container(),
                widget.couponPage ? Material(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // do-something
                      Navigator.pop(context, widget.snap);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: secondaryColor),
                      ),
                      child: const Text(
                        "APPLY",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ) : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
