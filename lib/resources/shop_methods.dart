import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/models/create_quote_model.dart';
import 'package:wbfactory/models/doordash/quote_response.dart';
import 'package:wbfactory/models/order_model.dart' as order_model;

import '../constants/consts.dart';
import '../constants/utils.dart';
import '../models/address_model.dart';
import '../models/authorize/transaction_response.dart';

class ShopMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final curUser = FirebaseAuth.instance.currentUser!.uid;

  Future<order_model.Order> getOrderDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('orders').doc(currentUser.uid).get();

    return order_model.Order.fromSnap(snap);
  }

  Future<String> addFavourite(
      {required Map<dynamic, dynamic> product, required String pid}) async {
    String res = "Some error occurred";

    try {
      await _firestore.collection('users').doc(curUser).set({
        'favourite': FieldValue.arrayUnion([
          product,
        ]),
        'favourite_list': FieldValue.arrayUnion([
          pid,
        ]),
      }, SetOptions(merge: true));

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> removeFavourite(
      {required Map<dynamic, dynamic> product, required String pid}) async {
    String res = "Some error occurred";

    try {
      await _firestore.collection('users').doc(curUser).set({
        'favourite': FieldValue.arrayRemove([
          product,
        ]),
        'favourite_list': FieldValue.arrayRemove([
          pid,
        ]),
      }, SetOptions(merge: true));

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // add address
  Future<String> addAddress({
    required Map<String, String> addressInput,
    required double latitude,
    required double longitude,
  }) async {
    String res = "Some error occurred";

    try {
      Address address = Address(
        title: addressInput['title']!,
        name: addressInput['name']!,
        street: addressInput['street']!,
        city: addressInput['city']!,
        country: addressInput['country']!,
        zip: addressInput['zip']!,
        phone: addressInput['phone']!,
        latitude: latitude,
        longitude: longitude,
      );

      await _firestore.collection('users').doc(curUser).set(
        {
          'address': FieldValue.arrayUnion([address.toJson()]),
        },
        SetOptions(merge: true),
      );

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // add to cart

  Future<String> addToCart({
    required String pid,
    required String itemName,
    required int quantity,
    required double itemPrice,
    required String category,
    required double packagePrice,
    required double totalPrice,
    required String itemImage,
    required bool? haveVarient,
    required bool? isQuantity,
    required List<String> selectedVarient,
    required List<double> selectedVarientPrice,
    required String? selectedQuantity,
    required double? selectedQuantityPrice,
    required context,
    required double cartAmount,
    required String? specialInstruction,
  }) async {
    String res = "Some error occurred";

    try {
      await _firestore.collection('cart').doc(curUser).set({
        'cart_amount': cartAmount,
        'items': FieldValue.arrayUnion([pid]),
        pid: {
          'pid': pid,
          'item_name': itemName,
          'item_image': itemImage,
          'quantity': quantity,
          'item_price': itemPrice,
          'category': category,
          'package_price': packagePrice,
          'total_price': totalPrice,
          'haveVarient': haveVarient,
          'selectedVarient': selectedVarient,
          'selectedVarientPrice': selectedVarientPrice,
          'isQuantity': isQuantity,
          'selectedQuantity': selectedQuantity,
          'selectedQuantityPrice': selectedQuantityPrice,
          'specialInstruction': specialInstruction,
        }
      }, SetOptions(merge: true));

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> updateCart({
    required String pid,
    required String itemName,
    required int quantity,
    required double itemPrice,
    required String category,
    required double packagePrice,
    required double totalPrice,
    required String itemImage,
    required bool? haveVarient,
    required bool? isQuantity,
    required List<dynamic> selectedVarient,
    required List<dynamic> selectedVarientPrice,
    required String? selectedQuantity,
    required double? selectedQuantityPrice,
    required context,
    required double cartAmount,
    required String? specialInstruction,
  }) async {
    String res = "Some error occurred";

    try {
      await _firestore.collection('cart').doc(curUser).update({
        'cart_amount': cartAmount,
        pid: {
          'pid': pid,
          'item_name': itemName,
          'item_image': itemImage,
          'quantity': quantity,
          'item_price': itemPrice,
          'category': category,
          'package_price': packagePrice,
          'total_price': totalPrice,
          'haveVarient': haveVarient,
          'selectedVarient': selectedVarient,
          'selectedVarientPrice': selectedVarientPrice,
          'isQuantity': isQuantity,
          'selectedQuantity': selectedQuantity,
          'selectedQuantityPrice': selectedQuantityPrice,
          'specialInstruction': specialInstruction,
        }
      });

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> deleteCart(
      {required String pid,
      required context,
      required double cartAmount}) async {
    String res = "Some error occurred";

    try {
      await _firestore.collection('cart').doc(curUser).update({
        pid: FieldValue.delete(),
        'items': FieldValue.arrayRemove([pid]),
        'cart_amount': cartAmount,
        'invoice_ref': generateInvoiceRef(),
      });

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // order functions

  Future<void> saveOrder({
    required String oid,
    required String name,
    required String phone,
    required String email,
    required int orderStatus,
    required bool paymentCompleted,
    required bool isCOD,
    required bool isPickup,
    required String pickupTime,
    required double orderTotal,
    required double discount,
    required double discountAmount,
    required double taxAmount,
    required double deliveryCost,
    required String? couponCode,
    required cart,
    required String orderTime,
    required context,
    required Map<String, dynamic>? deliveryInfo,
    required String? trackingUrl,
    String? deliveryId,
    TransactionResponse? transactionResponse,
    // required double? wbCoins,
    // required double? wbCash,
    CreateQuoteModel? quote,
    List<Item>? selectedItems,
  }) async {
    try {
      await _firestore.collection('orders').doc(curUser).set({
        'uid': curUser,
        'orders': FieldValue.arrayUnion([oid]),
        'unreviewed': FieldValue.arrayUnion([oid]),
      }, SetOptions(merge: true));

      print('-------> $quote <------');

      await _firestore.collection('allOrders').doc(oid).set({
        'uid': curUser,
        'oid': oid,
        'order_status': orderStatus,
        'payment_completed': paymentCompleted,
        'is_cod': isCOD,
        'is_pickup': isPickup,
        'pickup_time': pickupTime,
        'order_total': orderTotal,
        'discount': discount,
        'discount_amount': discountAmount,
        'tax_amount': taxAmount,
        'delivery_cost': deliveryCost,
        'coupon_code': couponCode,
        'cart': cart,
        'order_time': orderTime,
        'name': name,
        'email': email,
        'mobile': phone,
        // 'used_wb_coins': wbCoins,
        // 'used_wb_cash': wbCash,
        'tracking_url': trackingUrl,
        'usingDoorDash': trackingUrl != null,
        'delivery_info': deliveryInfo,
        'delivery_id': deliveryId,
        'read': false,
        'order_accepted': 0, //0: not decided; 1 : accepted; 2: cancelled
        'transaction': transactionResponse != null
            ? {
                "responseCode": transactionResponse.responseCode,
                "authCode": transactionResponse.authCode,
                "avsResultCode": transactionResponse.avsResultCode,
                "cvvResultCode": transactionResponse.cvvResultCode,
                "cavvResultCode": transactionResponse.cavvResultCode,
                "transId": transactionResponse.transId,
                "refTransID": transactionResponse.refTransID,
                "transHash": transactionResponse.transHash,
                "testRequest": transactionResponse.testRequest,
                "accountNumber": transactionResponse.accountNumber,
                "accountType": transactionResponse.accountType,
              }
            : null,
        'quote': quote != null ? quote.toJson() : null,
        'selected_items': selectedItems?.map((e) => e.toJson()).toList(),
      }, SetOptions(merge: true));

      if (couponCode != "") {
        await _firestore.collection('users').doc(curUser).set({
          'usedCoupons': FieldValue.arrayUnion([couponCode]),
        }, SetOptions(merge: true));
      }

      // // Handle Reward WB Coins & Cash
      // if (wbCoins != null || wbCash != null) {
      //   await _firestore.collection('coins').doc(curUser).set({
      //     if (wbCoins != null) 'coins': FieldValue.increment(-wbCoins),
      //     if (wbCash != null) 'cash': FieldValue.increment(-wbCash),
      //   }, SetOptions(merge: true));
      // }

    } catch (e) {
      customToast(e.toString(), darkGreyColor, context);
    }
  }

  Future<void> resetCart({required context}) async {
    try {
      await _firestore.collection('cart').doc(curUser).set({
        'uid': curUser,
        'cart_amount': 0.00,
        'items': [],
        'invoice_ref': generateInvoiceRef(),
      }, SetOptions(merge: false));
    } catch (e) {
      customToast(e.toString(), darkGreyColor, context);
    }
  }

  Future<String> stringResetCard({required context}) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('cart').doc(curUser).set({
        'uid': curUser,
        'cart_amount': 0.00,
        'items': [],
        'invoice_ref': generateInvoiceRef(),
      }, SetOptions(merge: false));

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<void> updateOrder({required int totalOrder}) async {
    try {
      await _firestore
          .collection('commons')
          .doc('orders')
          .update({'totalOrder': totalOrder});
    } catch (e) {}
  }
}
