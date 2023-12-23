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
                    widget.snap["order_status"] == 0 ? "In Process" : "Completed",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: widget.snap["order_status"] == 0 ? greenColor : darkGreyColor,
                    ),
                  ),
                ],
              ),
              4.heightBox,

              const Divider(),

              if (widget.snap['usingDoorDash'] != null && widget.snap['usingDoorDash'] == true) ...[
                TextButton(
                  onPressed: () async {
                    if (widget.snap['tracking_url'] != null) {
                      await launchUrlString(widget.snap['tracking_url']);
                    }
                  },
                  child: const Text('Click here to track order'),
                ),
              ],
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
              8.heightBox,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.snap["cart"]["items"].length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  var itemSnap = widget.snap["cart"][widget.snap["cart"]['items'][index]];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Row(
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
                                      fontWeight: FontWeight.w400,
                                      color: darkColor,
                                    ),
                                  ),
                                  Text(
                                    " • Qty: ${itemSnap['quantity']}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: darkColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),

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
                      fontWeight: FontWeight.w600,
                      color: widget.snap["payment_completed"] ? greenColor : redColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
