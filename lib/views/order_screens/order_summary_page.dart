import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/cards/fixed_cart_title.dart';
import 'package:wbfactory/constants/consts.dart';
import 'package:wbfactory/resources/authorize_gateway_service.dart';
import 'package:wbfactory/views/drawer/drawer_screens/setting_screens/address/add_address_screen.dart';
import 'package:wbfactory/views/home_screens/main_nav_page.dart';
import 'package:wbfactory/views/order_screens/payment_screen.dart';

import '../../components/buttons/back_button.dart';
import '../../components/buttons/main_button.dart';
import '../../constants/colors.dart';
import '../../data/store_address.dart';
import '../../models/create_quote_model.dart';
import '../../models/doordash/quote_response.dart';
import '../../resources/doordash_api_client.dart';

class CartSummaryPage extends StatefulWidget {
  final bool isPickup;
  final dynamic snap;

  const CartSummaryPage({
    super.key,
    required this.isPickup,
    required this.snap,
  });

  @override
  State<CartSummaryPage> createState() => _CartSummaryPageState();
}

class _CartSummaryPageState extends State<CartSummaryPage> {
  double deliveryCharge = 0.00;
  var taxData = {};
  var orderData = {};
  double tax = 0.00;
  int totalOrders = 0;
  String? deliveryId;
  String? dropOffPhone;

  getData() async {
    try {
      var commonSnap = await FirebaseFirestore.instance
          .collection('commons')
          .doc('tax')
          .get();

      var orderSnap = await FirebaseFirestore.instance
          .collection('commons')
          .doc('orders')
          .get();

      taxData = commonSnap.data()!;
      orderData = orderSnap.data()!;

      setState(() {
        tax = commonSnap['tax'].toDouble();
        totalOrders = orderData['totalOrder'];
      });
    } catch (e) {}
  }

  // for pickup time and date selection
  DateTime? selectedTime;
  late DateTime currentTime;
  late DateTime restaurantOpeningTime;
  late DateTime restaurantClosingTime;
  List<DateTime> availableTimes = [];

  List<DateTime> calculateAvailablePickupTimes(
      DateTime currentTime, DateTime openingTime, DateTime closingTime) {
    List<DateTime> times = [];
    DateTime time = openingTime;

    while (time.isBefore(closingTime)) {
      if (time.isAfter(currentTime.add(const Duration(minutes: 30)))) {
        times.add(time);
      }
      time = time.add(const Duration(minutes: 30));
    }

    return times;
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final DateTime pickedTime = availableTimes[index];

    setState(() {
      selectedTime = pickedTime;
    });
  }

  Future<void> _showTimePickerDialog(BuildContext context) async {
    DateTime? pickedTime = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: const Text('Select Pickup Time'),
          content: SizedBox(
            width: double.maxFinite,
            height: screenHeight(context) * 0.4,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: availableTimes.length,
              itemBuilder: (context, index) {
                final time = availableTimes[index];
                return ListTile(
                  title: Text(
                    '${time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(time);
                  },
                );
              },
            ),
          ),
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  // end

  @override
  void initState() {
    super.initState();
    // for pickup time and date
    // Initialize the current time and restaurant opening/closing times.
    currentTime = DateTime.now();
    restaurantOpeningTime = DateTime(
        currentTime.year, currentTime.month, currentTime.day, 17, 0); // 5:00 PM
    restaurantClosingTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, 24, 0, 1); // 10:00 PM

    // Calculate available pickup times at 30-minute intervals.
    availableTimes = calculateAvailablePickupTimes(
        currentTime, restaurantOpeningTime, restaurantClosingTime);

    try {
      getData();
    } catch (e) {
      customToast("Some error occurred", redColor, context);
    }
  }

  String? selectedAddress;
  Map<String, dynamic> selectedAddressFullInfo = {};
  QuoteResponse? quoteResponse;
  double totalDeliveryCost = 0.00;
  bool isPickup = true;
  double totalAmount = 0.00;

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
        actions: [
          IconButton(
            onPressed: () {
              Get.offAll(() => const NavScreen());
            },
            icon: const Icon(
              Icons.home_filled,
              color: secondaryColor,
            ),
          ),
          8.widthBox,
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Order Summary",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: darkColor,
                  ),
                ),
              ),
              12.heightBox,
              // Divider
              Container(
                height: 8,
                color: veryLightGreyColor,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.snap["items"].length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          var itemSnap =
                              widget.snap[widget.snap['items'][index]];

                          return FixedCartTile(
                            itemSnap: itemSnap,
                          );
                        },
                      ),
                      // Divider
                      Container(
                        height: 8,
                        color: veryLightGreyColor,
                      ),
                      widget.isPickup
                          ? Container(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 12,
                                bottom: 16,
                                top: 16,
                              ),
                              decoration: const BoxDecoration(
                                color: whiteColor,
                              ),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Pickup Time",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: darkColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  16.heightBox,
                                  selectedTime != null
                                      ? Row(
                                          children: [
                                            const Text(
                                              'Selected Pickup Time: ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                DateFormat('dd-MM-yyyy hh:mm a')
                                                    .format(selectedTime!),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const Text(
                                          'No Pickup Time Selected',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                  16.heightBox,
                                  MainButton(
                                    onTap: () => _showTimePickerDialog(context),
                                    title: 'Choose your Suitable Pickup Time',
                                    fontSize: 14,
                                    vertP: 12,
                                    color: secondaryColor.withOpacity(0.7),
                                    textColor: lightColor,
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 12,
                                bottom: 16,
                                top: 4,
                              ),
                              decoration: const BoxDecoration(
                                color: whiteColor,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Delivery Address",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: darkColor,
                                          ),
                                        ),
                                      ),
                                      8.widthBox,
                                      TextButton(
                                        onPressed: () {
                                          Get.to(
                                              () => const AddNewAddressPage());
                                        },
                                        child: const Text("Add New"),
                                      ),
                                    ],
                                  ),
                                  2.heightBox,
                                  // text-field
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>
                                            snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(
                                              color: primaryColor,
                                              strokeWidth: 2.0,
                                            ),
                                          ),
                                        );
                                      }

                                      final snap = snapshot.data!["address"];

                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: snap.length,
                                        shrinkWrap: true,
                                        itemBuilder: (
                                          BuildContext context,
                                          index,
                                        ) {
                                          final docSnap = snap[index];

                                          return RadioListTile<String>(
                                            title: Text(docSnap['title']),
                                            subtitle: Text(
                                              "${docSnap['street']}, ${docSnap['city']}, ${docSnap['country']}- ${docSnap['zip']}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            value: docSnap['title'],
                                            groupValue: selectedAddress,
                                            onChanged: (value) async {
                                              Get.defaultDialog(
                                                title: "Please Wait",
                                                middleText:
                                                    "Checking order rate...",
                                                barrierDismissible: false,
                                              );

                                              final quoteModel =
                                                  CreateQuoteModel(
                                                // externalDeliveryID:
                                                //     "TK-${widget.totalOrder}",
                                                dropoffAddress:
                                                    "${docSnap['street']}, ${docSnap['city']}, ${docSnap['country']}- ${docSnap['zip']}",
                                                dropoffBusinessName:
                                                    "${docSnap['name']}",
                                                dropoffLocation: {
                                                  "lat": docSnap['latitude']
                                                      .toDouble(),
                                                  "lng": docSnap['longitude']
                                                      .toDouble()
                                                },
                                                dropoffPhoneNumber:
                                                    "+12345672345",
                                                dropoffContactName:
                                                    "${docSnap['name']}",
                                                orderValue: 10,
                                              );

                                              final client =
                                                  DoordashApiClient();

                                              try {
                                                final result =
                                                    await client.createQuote(
                                                  dropoffAddress:
                                                      quoteModel.dropoffAddress,
                                                  dropoffBusinessName:
                                                      quoteModel
                                                          .dropoffBusinessName,
                                                  dropoffContactGivenName:
                                                      quoteModel
                                                          .dropoffContactName,
                                                  dropoffPhoneNumber: quoteModel
                                                      .dropoffPhoneNumber,
                                                  latitude: quoteModel
                                                      .dropoffLocation['lat']!
                                                      .toDouble(),
                                                  longitude: quoteModel
                                                      .dropoffLocation['lng']!
                                                      .toDouble(),
                                                  orderValue:
                                                      quoteModel.orderValue,
                                                  pickupAddress: pickupAddress,
                                                  pickupBusinessName:
                                                      pickupBusinessName,
                                                  pickupPhoneNumber:
                                                      pickupPhoneNumber,
                                                );

                                                final info = await client
                                                    .getDeliveryInfo(
                                                  result.externalDeliveryId!,
                                                );

                                                if (info.externalDeliveryId !=
                                                    null) {
                                                  deliveryId =
                                                      info.externalDeliveryId;
                                                  dropOffPhone =
                                                      info.dropoffPhoneNumber;
                                                }

                                                setState(() {
                                                  selectedAddress = value;
                                                  selectedAddressFullInfo =
                                                      docSnap;
                                                  quoteResponse = info;
                                                  deliveryCharge = info.fee !=
                                                          null
                                                      ? (info.fee ?? 0) / 100.0
                                                      : 9.00;
                                                });

                                                if (Get.isDialogOpen == true) {
                                                  Navigator.of(
                                                    Get.overlayContext!,
                                                  ).pop();
                                                }

                                                Get.snackbar(
                                                  "Success",
                                                  "Order rate calculated",
                                                  backgroundColor: Colors.green,
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  margin:
                                                      const EdgeInsets.all(16),
                                                  colorText: Colors.white,
                                                );
                                              } on FormatException catch (e) {
                                                e.message.log();
                                                if (Get.isDialogOpen == true) {
                                                  Navigator.of(
                                                    Get.overlayContext!,
                                                  ).pop();
                                                }
                                                Get.snackbar(
                                                  "Error",
                                                  e.message,
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  backgroundColor: primaryColor,
                                                  margin:
                                                      const EdgeInsets.all(16),
                                                  colorText: Colors.white,
                                                );
                                              } on Exception catch (e) {
                                                e.log();
                                                if (Get.isDialogOpen == true) {
                                                  Navigator.of(
                                                    Get.overlayContext!,
                                                  ).pop();
                                                }
                                                Get.snackbar(
                                                  "Error",
                                                  'Something went wrong',
                                                );
                                              } finally {
                                                if (Get.isDialogOpen == true) {
                                                  Navigator.of(
                                                    Get.overlayContext!,
                                                  ).pop();
                                                }
                                              }
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                      // Divider
                      Container(
                        height: 8,
                        color: veryLightGreyColor,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          bottom: 16,
                          top: 4,
                        ),
                        decoration: const BoxDecoration(
                          color: whiteColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Coupon Code",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: darkColor,
                                    ),
                                  ),
                                ),
                                8.widthBox,
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("See All"),
                                ),
                              ],
                            ),
                            2.heightBox,
                            Container(
                              decoration: BoxDecoration(
                                color: veryLightGreyColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  suffixIcon: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "APPLY",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 12,
                                  ),
                                  isDense: true,
                                  fillColor: veryLightGreyColor,
                                  hintText: "Enter the coupon code here",
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: darkGreyColor,
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            8.heightBox,
                            const Row(
                              children: [
                                Text(
                                  "Coupon Code applied",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: greenColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Divider
                      Container(
                        height: 8,
                        color: veryLightGreyColor,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: whiteColor,
                        ),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Text(
                                  "Payment Info",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                              ],
                            ),
                            12.heightBox,
                            Row(
                              children: [
                                const Text(
                                  "Order Mode : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Text(
                                  widget.isPickup ? " Pick up" : " Delivery",
                                  style: const TextStyle(
                                    fontSize: 15,
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
                                  "Price : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                8.widthBox,
                                Text(
                                  "\$ ${widget.snap["cart_amount"].toDouble().toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                              ],
                            ),
                            8.heightBox,
                            Row(
                              children: [
                                const Text(
                                  "Discount (CODE) : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                8.widthBox,
                                const Text(
                                  "-\$ 0.00",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                              ],
                            ),
                            8.heightBox,
                            Row(
                              children: [
                                const Text(
                                  "Tax (6%) : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                8.widthBox,
                                Text(
                                  "\$ ${(widget.snap["cart_amount"].toDouble() * 0.06).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                              ],
                            ),
                            8.heightBox,
                            Row(
                              children: [
                                const Text(
                                  "Delivery Charges : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                8.widthBox,
                                Text(
                                  "\$ ${deliveryCharge.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Divider
                      Container(
                        height: 1,
                        color: lightGreyColor,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: whiteColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Total Amount",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  "\$ ${(widget.snap["cart_amount"].toDouble() + widget.snap["cart_amount"].toDouble() * 0.06 + deliveryCharge).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            12.heightBox,
                            const Row(
                              children: [
                                Text(
                                  "You save \$ 0.00 on this order",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: greenColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      84.heightBox,
                    ],
                  ),
                ),
              ),
              Container(),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 12,
            right: 12,
            child: MainButton(
              title: "Proceed to payment",
              onTap: () {
                setState(
                  () {
                    final amount = widget.snap["cart_amount"].toDouble() +
                        widget.snap["cart_amount"].toDouble() * 0.06;

                    totalAmount = amount + (quoteResponse?.fee ?? 0.0) / 100.0;
                  },
                );

                if (widget.isPickup) {
                  if (selectedTime != null) {
                    Get.to(
                      () => PaymentScreen(
                        totalAmount: totalAmount,
                        totalOrder: totalOrders,
                        discount: 0.00,
                        cid: "",
                        snap: widget.snap,
                        selectedPickupTime: DateFormat(
                          'dd-MM-yyyy hh:mm a',
                        ).format(selectedTime!),
                        isPickup: widget.isPickup,
                      ),
                    );
                  } else {
                    customToast(
                      "Pick your preferred pickup time first.",
                      darkGreyColor,
                      context,
                    );
                  }
                } else {
                  if (quoteResponse == null) {
                    customToast(
                      "Please select delivery address first.",
                      darkGreyColor,
                      context,
                    );
                    return;
                  }

                  Get.to(
                    () => PaymentScreen(
                      totalAmount: totalAmount,
                      totalOrder: totalOrders,
                      discount: 0.00,
                      cid: "",
                      snap: widget.snap,
                      isPickup: widget.isPickup,
                      deliveryId: deliveryId,
                      dropOffPhone: dropOffPhone,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
