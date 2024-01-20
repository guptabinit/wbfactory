import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/views/other_screens/order_detail_screen.dart';

import '../../constants/colors.dart';

class OrderCard extends StatefulWidget {
  final dynamic snap;

  const OrderCard({
    super.key,
    required this.snap,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  String orderStatus() {
    if (widget.snap['order_status'] == 0) {
      return "In Process";
    } else if (widget.snap['order_status'] == 1) {
      return "Completed";
    }
    return "Cancelled";
  }

  Color colorStatus() {
    if (widget.snap['order_status'] == 0) {
      return secondaryColor;
    } else if (widget.snap['order_status'] == 1) {
      return greenColor;
    }
    return redColor;
  }

  String acceptedTextStatus() {
    if (widget.snap['order_accepted'] == 0) {
      return "Waiting for restaurant to accept";
    } else if (widget.snap['order_accepted'] == 1) {
      return "Order is accepted";
    }
    return "Cancelled by restaurant";
  }

  Color acceptedColorStatus() {
    if (widget.snap['order_accepted'] == 0) {
      return secondaryColor;
    } else if (widget.snap['order_accepted'] == 1) {
      return greenColor;
    }
    return redColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: lightBlue.withOpacity(0.6),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
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
                        "Order #${widget.snap["oid"]}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: darkColor,
                        ),
                      ),
                      2.heightBox,
                      Text(
                        widget.snap["is_pickup"] ? "Pickup" : "Delivery",
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
                        orderStatus(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: colorStatus(),
                        ),
                      ),
                      2.heightBox,
                      Text(
                        "${widget.snap["order_time"]}",
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
                color: lightGreyColor,
              ),
              6.heightBox,
              Row(
                children: [
                  Text(
                    "Payment Mode: ${widget.snap["is_cod"] ? "COD" : "Online"}",
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
                    "\$ ${widget.snap["order_total"].toDouble().toStringAsFixed(2)}",
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
                    widget.snap["payment_completed"] ? "PAID" : "UNPAID",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: widget.snap["payment_completed"]
                          ? greenColor
                          : redColor,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  8.widthBox,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => OrderDetailPage(
                            snap: widget.snap,
                          ));
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
        ),
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: acceptedColorStatus(),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
          ),
          child: Center(
            child: Text(
              acceptedTextStatus(),
              style: TextStyle(
                color: lightColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ],
    );
  }
}
