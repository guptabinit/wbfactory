import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/constants/consts.dart';
import 'package:wbfactory/models/card/card_info.dart';
import 'package:wbfactory/models/create_quote_model.dart';
import 'package:wbfactory/models/doordash/quote_response.dart';
import 'package:wbfactory/resources/shop_methods.dart';
import 'package:wbfactory/utils/send_notification.dart';
import 'package:wbfactory/views/order_screens/order_status_screen.dart';

import '../../models/authorize/transaction_response.dart';
import '../../provider/controller/payment_controller.dart';
import '../../resources/authorize_gateway_service.dart';

class CreditCardPaymentScreen extends StatefulWidget {
  final dynamic snap;
  final double amount;
  final double totalAmount;

  // final int totalOrder;
  final double discount;
  final double discountAmount;
  final double taxAmount;
  final String cid;
  final String selectedPickupTime;
  final bool isPickup;
  final double deliveryCost;
  final Map<dynamic, dynamic> userData;
  final String? deliveryId;
  final String? dropOffPhone;
  final Map<String, dynamic>? selectedAddressFullInfo;
  // final double? wbCoins;
  // final double? wbCash;
  final CreateQuoteModel? quoteModel;
  final List<Item>? kItems;
  final CardInfo? cardInfo;

  const CreditCardPaymentScreen({
    super.key,
    required this.snap,
    required this.amount,
    required this.totalAmount,
    // required this.totalOrder,
    required this.discount,
    required this.discountAmount,
    required this.taxAmount,
    required this.cid,
    required this.selectedPickupTime,
    required this.isPickup,
    required this.deliveryCost,
    required this.userData,
    required this.selectedAddressFullInfo,
    this.deliveryId,
    this.dropOffPhone,
    // required this.wbCoins,
    // required this.wbCash,
    required this.quoteModel,
    required this.kItems,
    this.cardInfo,
  });

  @override
  State<CreditCardPaymentScreen> createState() =>
      _CreditCardPaymentScreenState();
}

class _CreditCardPaymentScreenState extends State<CreditCardPaymentScreen> {
  bool isPaymentStarted = false;

  final formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  CardType? cardType = CardType.otherBrand;

  var orderData = {};

  int totalOrder = 0;

  List<CardInfo> savedCards = [];

  getTotalOrder() async {
    try {
      var orderSnap = await FirebaseFirestore.instance
          .collection('commons')
          .doc('orders')
          .get();

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

  @override
  void initState() {
    cardNumber = widget.cardInfo?.cardNumber ?? '';
    cardHolderName = widget.cardInfo?.cardHolderName ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.put(PaymentController());

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                cardType: cardType,
                cardBgColor: Theme.of(context).primaryColor,
                onCreditCardWidgetChange: (
                  CreditCardBrand brand,
                ) {},
              ),
              CreditCardForm(
                formKey: formKey,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: (CreditCardModel data) {
                  setState(() {
                    cardNumber = data.cardNumber;
                    expiryDate = data.expiryDate;
                    cardHolderName = data.cardHolderName;
                    cvvCode = data.cvvCode;
                    isCvvFocused = data.isCvvFocused;
                    cardType = data.cardNumber.cardType;
                  });
                },
                obscureCvv: true,
                obscureNumber: true,
                isHolderNameVisible: true,
                isCardNumberVisible: true,
                isExpiryDateVisible: true,
                enableCvv: true,
                cvvValidationMessage: 'Please input a valid CVV',
                dateValidationMessage: 'Please input a valid date',
                numberValidationMessage: 'Please input a valid number',
                autovalidateMode: AutovalidateMode.always,
                disableCardNumberAutoFillHints: false,
                inputConfiguration: const InputConfiguration(
                  cardNumberDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Number',
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  expiryDateDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expired Date',
                    hintText: 'XX/XX',
                  ),
                  cvvCodeDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CVV',
                    hintText: 'XXX',
                  ),
                  cardHolderDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card Holder',
                  ),
                  cardNumberTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                  cardHolderTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                  expiryDateTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                  cvvCodeTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 8.0,
                ),
                child: isPaymentStarted
                    ? const Center(child: CircularProgressIndicator())
                    : MainButton(
                        title: 'Pay \$${widget.totalAmount.toStringAsFixed(2)}',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            setState(() {
                              isPaymentStarted = true;
                            });

                            try {
                              final data = widget.snap?.data() as Map?;
                              final items = data?['items'] as List?;

                              final strItems =
                                  items?.map((el) => "$el").join(", ");

                              final invoiceRef =
                                  data?['invoice_ref']?.toString() ?? "";

                              if (invoiceRef.isEmptyOrNull) {
                                Get.snackbar(
                                  'Error',
                                  "We can't find the invoice reference, try to clean your cart.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 16.0,
                                  ),
                                );
                                return;
                              }

                              final contracts = ApiContracts(
                                creditCard: CreditCard(
                                  cardNumber: cardNumber,
                                  cardCode: cvvCode,
                                  expirationDate: expiryDate,
                                ),
                                orderDetails: OrderDetails(
                                  invoiceNumber: invoiceRef,
                                  description: '$strItems - items',
                                ),
                                amount: widget.totalAmount.toStringAsFixed(2),
                              );

                              await c.makePayment(contracts);

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(
                                    FirebaseAuth.instance.currentUser?.uid,
                                  )
                                  .update(
                                {
                                  'cards': FieldValue.arrayUnion(
                                    [
                                      {
                                        'card_number': cardNumber,
                                        'card_holder': cardHolderName,
                                      }
                                    ],
                                  ),
                                },
                              );

                              String? trackingUrl;
                              if (widget.deliveryId != null &&
                                  widget.dropOffPhone != null &&
                                  c.creditCardResponse.value?.messages
                                          ?.resultCode
                                          ?.toLowerCase() ==
                                      "ok") {
                                // try {
                                // final res = await DoordashApiClient()
                                //     .acceptDeliveryQuote(
                                //   deliveryId: widget.deliveryId!,
                                //   dropoffPhoneNumber: widget.dropOffPhone,
                                // );
                                // if (!res.containsKey('status') ||
                                //     res['status'] != true) {
                                //   Get.snackbar(
                                //     'Error',
                                //     'Delivery Failed',
                                //     snackPosition: SnackPosition.BOTTOM,
                                //     backgroundColor: Colors.red,
                                //   );
                                //   return;
                                // } else {
                                //   trackingUrl = res['tracking_url'];
                                // }
                                // } catch (e) {
                                //   Get.snackbar(
                                //     'Error',
                                //     e.toString(),
                                //     snackPosition: SnackPosition.BOTTOM,
                                //     backgroundColor: Colors.red,
                                //   );
                                //   return;
                                // }
                              }

                              await getTotalOrder();

                              if (c.creditCardResponse.value?.messages
                                      ?.resultCode
                                      ?.toLowerCase() ==
                                  "ok") {
                                final res = c.creditCardResponse.value
                                    ?.transactionResponse;

                                String oid = await storingInfo(
                                  res,
                                  trackingUrl,
                                  widget.quoteModel,
                                  widget.kItems,
                                );

                                Get.close(3);

                                Get.to(() => OrderStatusScreen(
                                      oid: oid,
                                      isPaid: true,
                                    ));
                              }
                            } catch (e) {
                              e.log();
                            } finally {
                              setState(() {
                                isPaymentStarted = false;
                              });
                            }
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> storingInfo([
    TransactionResponse? paymentIntentData,
    String? trackingUrl,
    CreateQuoteModel? selectedQuoteModel,
    List<Item>? items,
  ]) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('MM/dd/yy kk:mm:ss').format(now);

      String oid = "${totalOrder + 1}";

      await ShopMethods().saveOrder(
        name: widget.userData['full_name'],
        phone: widget.userData['mobile'],
        email: widget.userData['email'],
        oid: oid,
        orderStatus: 0,
        paymentCompleted: true,
        isCOD: false,
        orderTotal: widget.totalAmount,
        discount: widget.discount,
        couponCode: widget.cid,
        cart: widget.snap.data(),
        orderTime: formattedDate,
        context: context,
        isPickup: widget.isPickup,
        pickupTime: widget.selectedPickupTime,
        deliveryCost: widget.deliveryCost,
        trackingUrl: trackingUrl,
        transactionResponse: paymentIntentData,
        deliveryInfo: widget.selectedAddressFullInfo,
        deliveryId: widget.deliveryId,
        discountAmount: widget.discountAmount,
        taxAmount: widget.taxAmount,
        // wbCash: widget.wbCash,
        // wbCoins: widget.wbCoins,
        quote: selectedQuoteModel,
        selectedItems: items,
      );

      await resetCartFunction();

      await sendNotifications(oid);

      await ShopMethods().updateOrder(totalOrder: (totalOrder + 1));

      return oid;
    } catch (e) {
      if (mounted) {
        customToast('Payment Failed', redColor, context);
      }
    }
    return "error";
  }

  Future<void> resetCartFunction() async {
    await ShopMethods().resetCart(context: context);
  }
}

extension CreditCardType on String? {
  CardType? get cardType {
    if (this == null) return CardType.otherBrand;

    final types = detectCCType(this!);

    if (types.isNotEmpty) {
      final type = types.elementAt(0).type;

      switch (type) {
        case 'visa':
          return CardType.visa;
        case 'mastercard':
          return CardType.mastercard;
        case 'american_express':
          return CardType.americanExpress;
        case 'discover':
          return CardType.discover;
        case 'hipercard':
          return CardType.hipercard;
        case 'rupay':
          return CardType.rupay;
        case 'unionpay':
          return CardType.unionpay;
        case 'elo':
          return CardType.elo;
        default:
          return CardType.otherBrand;
      }
    }
    return CardType.otherBrand;
  }
}
