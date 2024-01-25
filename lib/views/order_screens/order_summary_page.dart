import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/cards/fixed_cart_title.dart';
import 'package:wbfactory/constants/consts.dart';
import 'package:wbfactory/models/coins.dart';
import 'package:wbfactory/resources/authorize_gateway_service.dart';
import 'package:wbfactory/resources/reward_methods.dart';
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
import '../other_screens/coupon_code_page.dart';

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

  // var couponData = {};
  double tax = 8.875;

  // int totalOrders = 0;
  String? deliveryId;
  String? dropOffPhone;

  // var cList = [];

  String? dropoffAddress;
  String? dropoffPhoneNumber;
  List<Item>? items;

  Map<String, dynamic> couponData = {};

  double discount = 0.00;

  String cid = '';

  bool couponApplied = false;

  List<dynamic> usedCoupons = [];

  bool _appliedWBCoins = false;
  bool _appliedWBCash = false;
  Coins? _wbCoins;
  double? _wbCash;

  getData() async {
    try {
      var taxSnap = await FirebaseFirestore.instance
          .collection('commons')
          .doc('tax')
          .get();

      var couponSnap = await FirebaseFirestore.instance
          .collection('commons')
          .doc('coupons')
          .get();

      var userUsedCoupon = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      // var couponSnap = await FirebaseFirestore.instance.collection('commons').doc('coupons').get();

      taxData = taxSnap.data()!;
      couponData = couponSnap.data()!;

      setState(() {
        tax = taxSnap['tax'].toDouble();
        usedCoupons = userUsedCoupon.data()!['usedCoupons'];
        // cList = couponData['code_list'];
      });
    } catch (e) {
      showCustomToast('Some error occurred', redColor);
    }
  }

  void showCustomToast(String message, Color color) {
    return customToast(message, color, context);
  }

  TextEditingController couponController = TextEditingController();

  // // bool isLoading = false;
  // dynamic appliedCoupon;
  bool isCouponValid = false;

  DateTime? selectedTime;
  late DateTime currentTime;
  late DateTime restaurantOpeningTime;
  late DateTime restaurantClosingTime;
  List<DateTime> availableTimes = [];

  List<DateTime> calculateAvailablePickupTimes(DateTime currentTime,
      DateTime openingTime, DateTime closingTime) {
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
            height: availableTimes.isEmpty
                ? screenHeight(context) * 0.1
                : screenHeight(context) * 0.4,
            child: availableTimes.isEmpty
                ? const Center(
                child: Text(
                  'Sorry!\nStore is closed now.\nCome back tomorrow.',
                  textAlign: TextAlign.center,
                ))
                : ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: availableTimes.length,
              padding: const EdgeInsets.only(bottom: 0),
              itemBuilder: (context, index) {
                final time = availableTimes[index];
                return ListTile(
                  title: Text(
                    '${time.hour}:${time.minute.toString().padLeft(
                        2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}',
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
        currentTime.year, currentTime.month, currentTime.day, 6, 0); // 6:00 AM
    restaurantClosingTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, 24, 00, 1); // 1:00 PM

    // Calculate available pickup times at 30-minute intervals.
    availableTimes = calculateAvailablePickupTimes(
        currentTime, restaurantOpeningTime, restaurantClosingTime);

    try {
      getData();
    } catch (e) {
      customToast('Some error occurred', redColor, context);
    }
  }

  String? selectedAddress;
  Map<String, dynamic> selectedAddressFullInfo = {};
  QuoteResponse? quoteResponse;
  double totalDeliveryCost = 0.00;
  bool isPickup = true;
  double totalAmount = 0.00;

  CreateQuoteModel? selectedQuoteModel;
  List<Item>? selectedItems;

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
                  'Order Summary',
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
                        padding: EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.snap['items'].length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          var itemSnap =
                          widget.snap[widget.snap['items'][index]];

                          return FixedCartTile(
                            itemSnap: itemSnap,
                          );
                        },
                      ),

                      // Order Summary

                      // // Divider
                      // Container(
                      //   height: 8,
                      //   color: veryLightGreyColor,
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.only(
                      //     left: 12,
                      //     right: 12,
                      //     bottom: 16,
                      //     top: 4,
                      //   ),
                      //   decoration: const BoxDecoration(
                      //     color: whiteColor,
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       8.heightBox,
                      //       Row(
                      //         children: [
                      //           const Expanded(
                      //             child: Text(
                      //               'Cooking Instruction (if any)',
                      //               style: TextStyle(
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.w500,
                      //                 color: darkColor,
                      //               ),
                      //             ),
                      //           ),
                      //           0.widthBox,
                      //         ],
                      //       ),
                      //       8.heightBox,
                      //       Container(
                      //         decoration: BoxDecoration(
                      //           color: veryLightGreyColor,
                      //           borderRadius: BorderRadius.circular(8),
                      //         ),
                      //         child: TextField(
                      //           controller: cookingInstructionController,
                      //           maxLines: 3,
                      //           decoration: const InputDecoration(
                      //             contentPadding: EdgeInsets.symmetric(
                      //               vertical: 16,
                      //               horizontal: 12,
                      //             ),
                      //             isDense: true,
                      //             fillColor: veryLightGreyColor,
                      //             hintText: 'Enter your cooking instruction here',
                      //             hintStyle: TextStyle(
                      //               fontSize: 14,
                      //               color: darkGreyColor,
                      //             ),
                      //             border: InputBorder.none,
                      //             focusedBorder: InputBorder.none,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                                    'Pickup Time',
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
                                    DateFormat('MM-dd-yyyy hh:mm a')
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
                                    'Delivery Address',
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
                                          () => const AddNewAddressPage(),
                                    );
                                  },
                                  child: const Text('Add New'),
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

                                final snap = snapshot.data!['address'];

                                return ListView.builder(
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.all(0),
                                  itemCount: snap.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context,
                                      index,) {
                                    final docSnap = snap[index];

                                    return RadioListTile<String>(
                                      title: Text(docSnap['title']),
                                      subtitle: Text(
                                        '${docSnap['street']}, ${docSnap['city']}, ${docSnap['country']}- ${docSnap['zip']}',
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
                                          title: 'Please Wait',
                                          middleText:
                                          'Checking order rate...',
                                          barrierDismissible: false,
                                        );

                                        final kItems = (widget
                                            .snap['items'] as List)
                                            .mapIndexed((e, i) =>
                                        (Item(
                                            name: widget.snap[
                                            widget.snap['items']
                                            [i]]['item_name'],
                                            quantity: widget.snap[
                                            widget.snap['items']
                                            [i]]['quantity'])))
                                            .toList();

                                        print('------- ${docSnap['phone']}');

                                        final quoteModel =
                                        CreateQuoteModel(
                                          // externalDeliveryID:
                                          //     'TK-${widget.totalOrder}',
                                          dropoffAddress:
                                          '${docSnap['street']}, ${docSnap['city']}, ${docSnap['country']}- ${docSnap['zip']}',
                                          dropoffBusinessName:
                                          '${docSnap['name']}',
                                          dropoffLocation: {
                                            'lat': docSnap['latitude']
                                                .toDouble(),
                                            'lng': docSnap['longitude']
                                                .toDouble()
                                          },
                                          dropoffPhoneNumber:
                                          '${docSnap['phone']}',
                                          dropoffContactName:
                                          '${docSnap['name']}',
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
                                            items: kItems,
                                          );

                                          selectedQuoteModel = quoteModel;
                                          selectedItems = kItems;

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
                                            deliveryId =
                                            info.externalDeliveryId!;
                                            dropoffAddress =
                                            info.dropoffAddress!;
                                            dropoffPhoneNumber =
                                            info.dropoffPhoneNumber!;
                                            items = info.items;
                                          });

                                          if (Get.isDialogOpen == true) {
                                            Navigator.of(
                                              Get.overlayContext!,
                                            ).pop();
                                          }

                                          Get.snackbar(
                                            'Success',
                                            'Order rate calculated',
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
                                            'Error',
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
                                            'Error',
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
                      _RewardCoins(
                        totalCartAmount: subCartAmount,
                        appliedWBCoins: _appliedWBCoins,
                        onAppliedWBCoins: (value, coins) {
                          setState(() {
                            _appliedWBCoins = value;
                            _wbCoins = coins;
                          });
                        },
                        appliedWBCash: _appliedWBCash,
                        onAppliedWBCash: (value, cash) {
                          setState(() {
                            _appliedWBCash = value;
                            _wbCash = cash;
                          });
                        },
                      ),
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
                                    'Coupon Code',
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
                                    Get.to(() =>
                                        CouponCodePage(
                                          usedCoupons: usedCoupons,
                                          data: couponData,
                                        ))?.then((couponSnap) {
                                      if (couponSnap != null) {
                                        setState(() {
                                          discount = couponSnap['discount']
                                              ?.toDouble();
                                          couponController.text =
                                          couponSnap['cid'];
                                          cid = couponSnap['cid'];
                                          couponApplied = true;
                                        });
                                      }
                                    });
                                  },
                                  child: const Text('Select Coupon'),
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
                                controller: couponController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  // suffixIcon: TextButton(
                                  //   onPressed: () {}, //checkCoupon(couponController.text),
                                  //   child: const Text(
                                  //     'APPLY',
                                  //     style: TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //       color: secondaryColor,
                                  //     ),
                                  //   ),
                                  // ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 12,
                                  ),
                                  isDense: true,
                                  fillColor: veryLightGreyColor,
                                  hintText: 'Select a coupon code',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: darkGreyColor,
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            8.heightBox,
                            couponApplied
                                ? const Row(
                              children: [
                                Text(
                                  'Coupon code applied successfully',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: greenColor,
                                  ),
                                ),
                              ],
                            )
                                : Container(),
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
                                  'Payment Info',
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
                                  'Order Mode : ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Text(
                                  widget.isPickup ? ' Pick up' : ' Delivery',
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
                                  'Sub Total : ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                8.widthBox,
                                Text(
                                  '\$ ${widget.snap['cart_amount']
                                      .toDouble()
                                      .toStringAsFixed(2)}',
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
                                Text(
                                  'Tax ($tax%) : ',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                8.widthBox,
                                Text(
                                  '\$ ${(double.parse(widget.snap['cart_amount']
                                      .toStringAsFixed(2)) * tax / 100)
                                      .toStringAsFixed(2)}',
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
                                Text(
                                  'Discount ($cid) : ',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                8.widthBox,
                                Text(
                                  '-\$ ${((double.parse((double.parse(
                                      widget.snap['cart_amount']
                                          .toStringAsFixed(2)) * tax / 100)
                                      .toStringAsFixed(2)) + double.parse(
                                      widget.snap['cart_amount']
                                          .toStringAsFixed(2))) * discount /
                                      100).toStringAsFixed(2)}',
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
                                  'Delivery Charges : ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkGreyColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                8.widthBox,
                                Text(
                                  '\$ ${deliveryCharge.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: darkColor,
                                  ),
                                ),
                              ],
                            ),
                            if (_appliedWBCoins && _wbCoins != null) ...[
                              8.heightBox,
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Used WB Coins',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: darkGreyColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '- \$${_wbCoinsAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            if (_appliedWBCash && _wbCash != 0) ...[
                              8.heightBox,
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Used WB Cash',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: darkGreyColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '- \$${_wbCashAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                                  'Total Amount',
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
                                  '\$${_totalCartAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            12.heightBox,
                            Row(
                              children: [
                                Text(
                                  'You save \$ ${((double.parse((double.parse(
                                      widget.snap['cart_amount']
                                          .toStringAsFixed(2)) * tax / 100)
                                      .toStringAsFixed(2)) + double.parse(
                                      widget.snap['cart_amount']
                                          .toStringAsFixed(2))) * discount /
                                      100).toStringAsFixed(2)} on this order',
                                  style: const TextStyle(
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
            bottom: 24,
            left: 12,
            right: 12,
            child: MainButton(
              title: 'Proceed to payment',
              onTap: () {
                setState(
                      () {
                    final amount = _totalCartAmount;

                    totalAmount = amount + (quoteResponse?.fee ?? 0.0) / 100.0;
                  },
                );

                if (widget.isPickup) {
                  if (selectedTime != null) {
                    Get.to(
                          () =>
                          PaymentScreen(
                            totalAmount: totalAmount,
                            // totalOrder: totalOrders,
                            discount: discount,
                            cid: cid,
                            snap: widget.snap,
                            selectedPickupTime: DateFormat(
                              'MM-dd-yyyy hh:mm a',
                            ).format(selectedTime!),
                            isPickup: widget.isPickup,
                            selectedAddressFullInfo: selectedAddressFullInfo,
                            discountAmount: double.parse(((double.parse(
                                (double.parse(widget.snap['cart_amount']
                                    .toStringAsFixed(2)) *
                                    tax /
                                    100)
                                    .toStringAsFixed(2)) +
                                double.parse(widget.snap['cart_amount']
                                    .toStringAsFixed(2))) *
                                discount /
                                100)
                                .toStringAsFixed(2)),
                            taxAmount: double.parse((double.parse(widget
                                .snap['cart_amount']
                                .toStringAsFixed(2)) *
                                tax /
                                100)
                                .toStringAsFixed(2)),
                            wbCoins: (_appliedWBCoins && _wbCoins != null)
                                ? Coins.convertAmountToCoin(_wbCoinsAmount)
                                : null,
                            wbCash: (_appliedWBCash && _wbCash != null)
                                ? _wbCashAmount
                                : null,
                          ),
                    );
                  } else {
                    customToast(
                      'Pick your preferred pickup time first.',
                      darkGreyColor,
                      context,
                    );
                  }
                } else {
                  DateTime currentTime = DateTime.now();

                  DateTime startTime = DateTime(
                    currentTime.year,
                    currentTime.month,
                    currentTime.day,
                    6,
                    0,
                  );

                  DateTime endTime = DateTime(
                    currentTime.year,
                    currentTime.month,
                    currentTime.day,
                    24,
                    0,
                  );

                  if (
                  currentTime.isAfter(startTime) &&
                      currentTime.isBefore(endTime)
                  ) {
                    if (quoteResponse == null) {
                      customToast(
                        'Please select delivery address first.',
                        darkGreyColor,
                        context,
                      );
                      return;
                    }

                    print('---------');
                    print(selectedQuoteModel);
                    print(selectedItems);
                    print('---------');

                    Get.to(
                          () =>
                          PaymentScreen(
                            totalAmount: totalAmount,
                            // totalOrder: totalOrders,
                            deliveryCost: deliveryCharge,
                            discount: discount,
                            cid: cid,
                            snap: widget.snap,
                            isPickup: widget.isPickup,
                            deliveryId: deliveryId,
                            dropOffPhone: dropOffPhone,
                            selectedAddressFullInfo: selectedAddressFullInfo,
                            discountAmount: double.parse(((double.parse(
                                (double.parse(widget.snap['cart_amount']
                                    .toStringAsFixed(2)) *
                                    tax /
                                    100)
                                    .toStringAsFixed(2)) +
                                double.parse(widget.snap['cart_amount']
                                    .toStringAsFixed(2))) *
                                discount /
                                100)
                                .toStringAsFixed(2)),
                            taxAmount: double.parse((double.parse(widget
                                .snap['cart_amount']
                                .toStringAsFixed(2)) *
                                tax /
                                100)
                                .toStringAsFixed(2)),
                            wbCoins: (_appliedWBCoins && _wbCoins != null)
                                ? Coins.convertAmountToCoin(_wbCoinsAmount)
                                : null,
                            wbCash: (_appliedWBCash && _wbCash != null)
                                ? _wbCashAmount
                                : null,
                            quoteModel: selectedQuoteModel,
                            kItems: selectedItems,
                          ),
                    );
                  } else {
                    customToast(
                        'Store is closed. Order between 06:00 AM and 01:00 PM.',
                        redColor,
                        context);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  double get subCartAmount {
    return double.parse(
        (double.parse(widget.snap['cart_amount'].toStringAsFixed(2)) +
            double.parse(
                (double.parse(widget.snap['cart_amount'].toStringAsFixed(2)) *
                    tax /
                    100)
                    .toStringAsFixed(2)) -
            double.parse(((double.parse((double.parse(
                widget.snap['cart_amount'].toStringAsFixed(2)) *
                tax /
                100)
                .toStringAsFixed(2)) +
                double.parse(widget.snap['cart_amount'].toStringAsFixed(2))) *
                discount /
                100)
                .toStringAsFixed(2)))
            .toStringAsFixed(2));
  }

  double get _totalCartAmount {
    double totalCartAmount = subCartAmount;

    if (_appliedWBCoins && _wbCoins != null) {
      totalCartAmount = totalCartAmount - _wbCoinsAmount;
    }

    if (_appliedWBCash && _wbCash != null) {
      totalCartAmount = totalCartAmount - _wbCashAmount;
    }
    return totalCartAmount.isNegative ? 0 : totalCartAmount;
  }

  double get _wbCoinsAmount {
    double coinsAmount = _wbCoins?.usedCoinAmount ?? 0.0;
    if (coinsAmount > subCartAmount) {
      coinsAmount = subCartAmount;
    }
    return coinsAmount;
  }

  double get _wbCashAmount {
    double cashAmount = _wbCash ?? 0.0;
    if (cashAmount > subCartAmount) {
      cashAmount = subCartAmount;
    }
    return cashAmount;
  }
}

class _RewardCoins extends StatelessWidget {
  final double totalCartAmount;
  final bool appliedWBCoins;
  final bool appliedWBCash;
  final Function(bool, Coins?) onAppliedWBCoins;
  final Function(bool, double) onAppliedWBCash;

  const _RewardCoins({
    required this.totalCartAmount,
    required this.appliedWBCoins,
    required this.appliedWBCash,
    required this.onAppliedWBCoins,
    required this.onAppliedWBCash,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
    return StreamBuilder<Coins>(
      stream: RewardMethods.coinsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Coins? coins = snapshot.data;
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ).copyWith(top: 16, bottom: 16),
            decoration: const BoxDecoration(
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Redeem Rewards',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                12.heightBox,
                Row(
                  children: [
                    SizedBox.square(
                      dimension: 18,
                      child: Checkbox(
                        value: appliedWBCoins,
                        onChanged: ((coins?.totalAmount ?? 0) >= 8) &&
                            ((coins?.totalAmount ?? 0) >= 8)
                            ? (value) {
                          onAppliedWBCoins(value ?? false, coins);
                        }
                            : null,
                      ),
                    ),
                    20.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WB Coins: ${coins?.coins?.toStringAsFixed(0)}',
                            style: textStyle,
                          ),
                          5.heightBox,
                          Text(
                            '${coins?.coins?.toStringAsFixed(
                                0)} WB Coins = \$${coins?.totalAmount
                                .toStringAsFixed(2)}',
                            style: textStyle.copyWith(
                              fontSize: 13,
                              color: lightGreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                20.heightBox,
                Row(
                  children: [
                    SizedBox.square(
                      dimension: 18,
                      child: Checkbox(
                        value: appliedWBCash,
                        onChanged: (coins?.cash ?? 0.0) >= totalCartAmount
                            ? (value) {
                          onAppliedWBCash(value ?? false,
                              coins?.cash?.toDouble() ?? 0.0);
                        }
                            : null,
                      ),
                    ),
                    15.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WB Cash: \$${coins?.cash?.toStringAsFixed(2)}',
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
