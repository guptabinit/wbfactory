import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/views/other_screens/order_detail_screen.dart';

import '../../constants/colors.dart';

class OrderCard extends StatelessWidget {
  final dynamic snap;

  const OrderCard({
    super.key,
    required this.snap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: lightBlue.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  CupertinoIcons.bag,
                  color: lightColor,
                  size: 28,
                ),
              ),
              8.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Order #${snap["oid"]}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: darkColor,
                    ),
                  ),
                  2.heightBox,
                   Text(
                    snap["is_pickup"] ? "Pickup": "Delivery",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: darkColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              8.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    snap["order_status"] == 0 ? "ACTIVE" : "FINISHED",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: snap["order_status"] == 0  ? greenColor : darkGreyColor,
                    ),
                  ),
                  2.heightBox,
                   Text(
                    "${snap["order_time"]}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: darkGreyColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          8.heightBox,
          const Divider(
            color: darkGreyColor,
          ),
          6.heightBox,
          Row(
            children: [
               Text(
                "Payment Mode: ${snap["is_cod"] ? "COD" : "Online" }",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: darkColor,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              8.widthBox,
               Text(
                "\$ ${snap["order_total"].toDouble().toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: darkColor,
                ),
              ),
            ],
          ),
          6.heightBox,
          Row(
            children: [
              const Text(
                "Payment Status: ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: darkColor,
                ),
              ),
              Text(
                snap["payment_completed"] ? "PAID" : "UNPAID",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: snap["payment_completed"]  ? greenColor : redColor,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              8.widthBox,
              GestureDetector(
                onTap: () {
                  Get.to(() => OrderDetailPage(snap: snap,));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    "MORE INFO",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
