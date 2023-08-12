import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.heightBox,
              const Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: darkColor,
                ),
              ),
              8.heightBox,
              const Text(
                "Here you can take look at all your previous orders and also repeat the same previous order.",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: darkGreyColor,
                ),
              ),
              12.heightBox,
              orderWidget(true, false),
              12.heightBox,
              orderWidget(true, true),
              12.heightBox,
              orderWidget(false, true),
              12.heightBox,
              orderWidget(false, true),
              12.heightBox,
              orderWidget(false, true),
              12.heightBox,
              orderWidget(false, true),
              12.heightBox,
              orderWidget(false, true),
              12.heightBox,
            ],
          ),
        ),
      ),
    );
  }

  Widget orderWidget(bool isActive, bool isPaid) {
    return Container(
      padding: const EdgeInsets.all(12),
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
                  const Text(
                    "Order #121323",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: darkColor,
                    ),
                  ),
                  2.heightBox,
                  const Text(
                    "Pickup/Delivery",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
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
                    isActive ? "ACTIVE" : "FINISHED",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isActive ? greenColor : darkGreyColor,
                    ),
                  ),
                  2.heightBox,
                  const Text(
                    "12 October 2023",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
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
              const Text(
                "Item Ordered: 12 nos",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: darkColor,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              8.widthBox,
              const Text(
                "\$ 42.00",
                style: TextStyle(
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
                isPaid ? "PAID" : "UNPAID",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isPaid ? greenColor : redColor,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              8.widthBox,
              GestureDetector(
                onTap: () {},
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
