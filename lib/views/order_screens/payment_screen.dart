import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/constants/consts.dart';
import 'package:wbfactory/resources/shop_methods.dart';

import '../../components/buttons/back_button.dart';
import '../../models/authorize/transaction_response.dart';
import 'credit_card_payment_screen.dart';
import 'order_placed_screen.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;

  // final int totalOrder;
  final double discount;
  final String cid;
  final String cookingInstruction;
  final snap;
  final String selectedPickupTime;
  final bool isPickup;
  final double deliveryCost;
  final String? deliveryId;
  final String? dropOffPhone;
  final Map<String, dynamic>? selectedAddressFullInfo;

  const PaymentScreen({
    super.key,
    required this.totalAmount,
    // required this.totalOrder,
    required this.discount,
    required this.cookingInstruction,
    required this.cid,
    required this.snap,
    this.selectedPickupTime = "",
    this.deliveryCost = 0.00,
    required this.isPickup,
    required this.selectedAddressFullInfo,
    this.deliveryId,
    this.dropOffPhone,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isCod = false;
  bool isLoading = false;
  var userData = {};

  Map<String, dynamic>? paymentIntentData;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getData();
    });
  }

  var orderData = {};

  int totalOrder = 0;

  getTotalOrder() async {
    try {
      var orderSnap = await FirebaseFirestore.instance.collection('commons').doc('orders').get();

      orderData = orderSnap.data()!;

      setState(() {
        totalOrder = orderData['totalOrder'];
      });
    } catch (e) {
      if (mounted) {
        customToast(e.toString(), redColor, context);
      }
    }
  }

  getData() async {
    try {
      var snap = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

      setState(() {
        userData = snap.data()!;
      });
    } catch (e) {
      if (mounted) {
        customToast(e.toString(), darkGreyColor, context);
      }
    }
  }

  // storingInfo([TransactionResponse? paymentIntentData]) async {
  //   try {
  //     DateTime now = DateTime.now();
  //     String formattedDate = DateFormat('dd/MM/yy kk:mm:ss').format(now);
  //
  //     String oid = "${widget.totalOrder + 1}";
  //
  //     await ShopMethods().saveOrder(
  //       name: userData['full_name'],
  //       phone: userData['mobile'],
  //       email: userData['email'],
  //       oid: oid,
  //       orderStatus: 0,
  //       paymentCompleted: true,
  //       isCOD: false,
  //       orderTotal: widget.totalAmount,
  //       discount: widget.discount,
  //       couponCode: widget.cid,
  //       cart: widget.snap.data(),
  //       orderTime: formattedDate,
  //       context: context,
  //       isPickup: widget.isPickup,
  //       pickupTime: widget.selectedPickupTime,
  //       deliveryCost: widget.deliveryCost,
  //       transactionResponse: paymentIntentData,
  //     );
  //
  //     await resetCartFunction();
  //
  //     await ShopMethods().updateOrder(totalOrder: (widget.totalOrder + 1));
  //   } catch (e) {
  //     if (mounted) {
  //       customToast('Payment Failed', redColor, context);
  //     }
  //   }
  // }

  calculateAmount() {
    final price = (double.parse(widget.totalAmount.toStringAsFixed(2)) * 100).toInt().toString();

    return price.toString;
  }

  Future<void> resetCartFunction() async {
    await ShopMethods().resetCart(context: context);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Payment Summary",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
            16.heightBox,
            Container(
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0, 1),
                    blurRadius: 1,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Payment Method",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        12.heightBox,
                        Row(
                          children: [
                            widget.isPickup
                                ? Expanded(
                                    child: GestureDetector(
                                      onTap: widget.isPickup
                                          ? () {
                                              setState(() {
                                                isCod = true;
                                              });
                                            }
                                          : () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: widget.isPickup
                                              ? isCod
                                                  ? secondaryColor
                                                  : Colors.grey.shade200
                                              : Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "COD",
                                                style: TextStyle(
                                                  color: isCod ? lightColor : darkColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              widget.isPickup ? Container() : 4.widthBox,
                                              widget.isPickup
                                                  ? Container()
                                                  : const Text(
                                                      "DISABLED",
                                                      style: TextStyle(
                                                        color: darkColor,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            widget.isPickup ? 8.widthBox : Container(),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCod = false;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isCod ? Colors.grey.shade200 : secondaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "ONLINE PAY",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: isCod ? darkColor : lightColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            28.heightBox,
            Expanded(
              child: Text(
                "Total Payable Amount: \$${widget.totalAmount.toStringAsFixed(2)}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            12.heightBox,
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: secondaryColor,
                    ),
                  )
                : MainButton(
                    title: "Complete Order",
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });

                      await getTotalOrder();

                      if (isCod == true && context.mounted) {
                        DateTime now = DateTime.now();
                        String formattedDate = DateFormat(
                          'dd/MM/yy kk:mm:ss',
                        ).format(now);

                        String oid = "${totalOrder + 1}";

                        if (!mounted) return null;

                        await ShopMethods().saveOrder(
                          name: userData['full_name'],
                          phone: userData['mobile'],
                          email: userData['email'],
                          oid: oid,
                          orderStatus: 0,
                          paymentCompleted: false,
                          isCOD: true,
                          orderTotal: widget.totalAmount,
                          discount: widget.discount,
                          couponCode: widget.cid,
                          cart: widget.snap.data(),
                          orderTime: formattedDate,
                          context: context,
                          isPickup: widget.isPickup,
                          pickupTime: widget.selectedPickupTime,
                          deliveryCost: widget.deliveryCost,
                          trackingUrl: null,
                          deliveryInfo: widget.selectedAddressFullInfo,
                          cookingInstruction: widget.cookingInstruction,
                        );

                        await resetCartFunction();

                        await ShopMethods().updateOrder(totalOrder: (totalOrder + 1));

                        setState(() {
                          isLoading = false;
                        });

                        Get.close(3);
                        Get.to(() => const OrderPlacedScreen());
                      } else if (isCod == false) {
                        // await makePayment();
                        // setState(() {
                        //   isLoading = false;
                        // });

                        Get.to(
                          () => CreditCardPaymentScreen(
                            amount: (double.parse(widget.totalAmount.toStringAsFixed(2)) * 100),
                            snap: widget.snap,
                            totalAmount: widget.totalAmount,
                            // totalOrder: widget.totalOrder,
                            discount: widget.discount,
                            cid: widget.cid,
                            selectedPickupTime: widget.selectedPickupTime,
                            isPickup: widget.isPickup,
                            deliveryCost: widget.deliveryCost,
                            userData: userData,
                            deliveryId: widget.deliveryId,
                            dropOffPhone: widget.dropOffPhone,
                            cookingInstruction: widget.cookingInstruction,
                            selectedAddressFullInfo: widget.selectedAddressFullInfo,
                          ),
                        );

                        setState(() {
                          isLoading = false;
                        });
                      }

                      // Get.to(() => const AddCardScreen());

                      // showSnackBar("Under Development", context);
                    },
                  ),
            12.heightBox,
          ],
        ),
      ),
    );
  }
}
