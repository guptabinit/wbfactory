import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../components/buttons/back_button.dart';
import '../../constants/colors.dart';

class OrderDetailPage extends StatefulWidget {
  final dynamic snap;

  const OrderDetailPage({super.key, required this.snap});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
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

  String did = "";

  @override
  void initState() {
    try{
      setState(() {
        did = widget.snap['delivery_id'];
      });
    } catch (e) {
      print("did doesn't exists.");
    }
    super.initState();
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Order Summary",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: darkColor,
                ),
              ),
              const Divider(),
              4.heightBox,
              Row(
                children: [
                  const Text(
                    "Order No.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Text(
                    " #${widget.snap["oid"]}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: secondaryColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    orderStatus(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorStatus(),
                    ),
                  ),
                ],
              ),
              4.heightBox,

              if (widget.snap['is_pickup'] == false &&
                  widget.snap['order_accepted'] == 1) ...[
                const Divider(),
              ],

              if (widget.snap['is_pickup'] == false &&
                  widget.snap['order_accepted'] == 1) ...[
                ElevatedButton(
                  onPressed: () async {
                    if (widget.snap['tracking_url'] != null) {
                      await launchUrlString(widget.snap['tracking_url']);
                    }
                  },
                  child: const Text('Click here to track order'),
                ),
              ],
              const Divider(),

              // Important Info Section

              8.heightBox,
              const Text(
                "Important Info",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textDarkGreyColor,
                ),
              ),
              12.heightBox,
              Row(
                children: [
                  const Text(
                    "Mode:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Text(
                    widget.snap["is_pickup"] ? " Pickup" : "Delivery",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                children: [
                  const Text(
                    "Total Amount:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Text(
                    " \$ ${widget.snap['order_total'].toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: darkColor,
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pickup Time:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${widget.snap["pickup_time"]}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: darkColor,
                      ),
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Payment Mode: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.snap['is_cod'] ? "COD" : "Online",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: darkColor,
                      ),
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Payment Status: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.snap['payment_completed'] ? "PAID" : "UNPAID",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: widget.snap["payment_completed"]
                            ? greenColor
                            : redColor,
                      ),
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Status: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      orderStatus(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colorStatus(),
                      ),
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Time: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${widget.snap['order_time']}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: darkColor,
                      ),
                    ),
                  ),
                ],
              ),
              8.heightBox,

              const Divider(),

              // Order Info Section

              8.heightBox,
              const Text(
                "Order Info",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textDarkGreyColor,
                ),
              ),
              12.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pickup / Delivery:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${widget.snap["is_pickup"] ? "Pickup" : "Delivery"}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                children: [
                  const Text(
                    "Total Amount:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " \$ ${widget.snap["order_total"].toDouble().toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: darkColor,
                      ),
                    ),
                  ),
                ],
              ),
              12.heightBox,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.snap["cart"]["items"].length,
                padding: const EdgeInsets.only(bottom: 0),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  var itemSnap =
                      widget.snap["cart"][widget.snap["cart"]['items'][index]];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                height: 72,
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: CachedNetworkImage(
                                    key: UniqueKey(),
                                    imageUrl: itemSnap['item_image'],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            16.widthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    itemSnap['category'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: secondaryColor,
                                    ),
                                  ),
                                  2.heightBox,
                                  Text(
                                    itemSnap['item_name'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: darkColor,
                                    ),
                                  ),
                                  4.heightBox,
                                  Row(
                                    children: [
                                      Text(
                                        "\$ ${itemSnap['package_price'].toDouble().toStringAsFixed(2)}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: darkColor,
                                        ),
                                      ),
                                      Text(
                                        " • Qty: ${itemSnap['quantity']}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: darkColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        6.heightBox,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                itemSnap["isQuantity"]
                                    ? "Choice: ${itemSnap["selectedQuantity"]} (\$ ${itemSnap["selectedQuantityPrice"].toDouble().toStringAsFixed(2)})"
                                    : "Choice: No Choices Chosen.",
                                style: const TextStyle(
                                  color: darkGreyColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Container(),
                          ],
                        ),
                        itemSnap['selectedVarient'].length == 0
                            ? Container()
                            : 4.heightBox,
                        itemSnap['selectedVarient'].length == 0
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Variants: ",
                                    style: TextStyle(
                                      color: darkGreyColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${itemSnap['selectedVarient']}",
                                      style: const TextStyle(
                                        color: darkGreyColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        itemSnap['specialInstruction'] == ""
                            ? Container()
                            : 4.heightBox,
                        itemSnap['specialInstruction'] == ""
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Sp. Instruction: ",
                                    style: TextStyle(
                                      color: darkGreyColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${itemSnap['specialInstruction']}",
                                      style: const TextStyle(
                                        color: darkGreyColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  );
                },
              ),

              const Divider(),

              // Personal Info Section

              8.heightBox,
              const Text(
                "Personal Info",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textDarkGreyColor,
                ),
              ),
              12.heightBox,
              Row(
                children: [
                  const Text(
                    "Name:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Text(
                    " ${widget.snap["name"]}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                children: [
                  const Text(
                    "Phone:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Text(
                    " ${widget.snap["mobile"]}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: darkColor,
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email Address:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${widget.snap["email"]}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: darkColor,
                      ),
                    ),
                  ),
                ],
              ),
              8.heightBox,

              const Divider(),

              // Payment Info Section

              8.heightBox,
              const Text(
                "Payment Info",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textDarkGreyColor,
                ),
              ),
              12.heightBox,

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sub Total: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "\$ ${widget.snap["cart"]["cart_amount"].toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: darkColor,
                      ),
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tax: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "\$ ${widget.snap["tax_amount"].toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: darkColor,
                      ),
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discount [${widget.snap["coupon_code"]}]: ",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "\$ ${widget.snap["discount_amount"].toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: darkColor,
                      ),
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Delivery: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "\$ ${widget.snap["delivery_cost"].toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: darkColor,
                      ),
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Amount: ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "\$ ${widget.snap["order_total"].toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                children: [
                  const Text(
                    "Payment Status:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Text(
                    widget.snap["payment_completed"] ? " PAID" : " UNPAID",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: widget.snap["payment_completed"]
                          ? greenColor
                          : redColor,
                    ),
                  ),
                ],
              ),
              8.heightBox,
              Row(
                children: [
                  const Text(
                    "Payment Mode:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: darkColor,
                    ),
                  ),
                  Text(
                    " ${widget.snap["is_cod"] ? "COD" : "Online"}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
              8.heightBox,
              widget.snap["is_cod"]
                  ? Container()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Transaction ID:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: darkColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            " ${widget.snap["transaction"]["transId"]}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: darkColor,
                            ),
                          ),
                        ),
                      ],
                    ),
              8.heightBox,
              const Divider(),
              8.heightBox,
              // Delivery Info Card
              widget.snap['is_pickup']
                  ? Container()
                  : Column(
                      children: [
                        const Text(
                          "Delivery Info",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: textDarkGreyColor,
                          ),
                        ),
                        12.heightBox,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Address: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: darkColor,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${widget.snap['delivery_info']['street']}, ${widget.snap['delivery_info']['city']}, ${widget.snap['delivery_info']['country']} - ${widget.snap['delivery_info']['zip']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        6.heightBox,
                        Row(
                          children: [
                            const Text(
                              "Phone: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: darkColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${widget.snap['delivery_info']['phone']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: darkColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        6.heightBox,
                        Row(
                          children: [
                            const Text(
                              "Name: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: darkColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget.snap['delivery_info']['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: darkColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        6.heightBox,
                        Row(
                          children: [
                            const Text(
                              "Address Type: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: darkColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget.snap['delivery_info']['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: secondaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        6.heightBox,
                        Row(
                          children: [
                            const Text(
                              "Delivery ID: ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: darkColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              did,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: secondaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        42.heightBox,
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
