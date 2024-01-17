import 'dart:convert';
import 'dart:developer' as developer show log;

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;

import '../models/authorize/credit_card_response.dart';

@immutable
class CreditCard extends Equatable {
  final String cardNumber;
  final String expirationDate;
  final String cardCode;

  const CreditCard({
    required this.cardNumber,
    required this.expirationDate,
    required this.cardCode,
  });

  @override
  List<Object?> get props => [
    cardNumber,
    expirationDate,
    cardCode,
  ];

  @override
  String toString() => 'CreditCard{cardNumber: $cardNumber, '
      'expirationDate: $expirationDate, '
      'cardCode: $cardCode}';
}

@immutable
class OrderDetails {
  final String? invoiceNumber;
  final String? description;

  const OrderDetails({
    required this.invoiceNumber,
    required this.description,
  });
}

@immutable
class Address extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? address;
  final String? city;
  final String? state;
  final String? zip;
  final String? country;

  const Address({
    this.firstName,
    this.lastName,
    this.company,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.country,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    company,
    address,
    city,
    state,
    zip,
    country,
  ];

  @override
  String toString() => 'Address{firstName: $firstName, '
      'lastName: $lastName, '
      'company: $company, '
      'address: $address, '
      'city: $city, '
      'state: $state, '
      'zip: $zip, '
      'country: $country}';
}

@immutable
class BillTo extends Address {}

@immutable
class ShipTo extends Address {}

@immutable
class ApiContracts extends Equatable {
  final CreditCard creditCard;
  final String amount;
  final OrderDetails orderDetails;
  final BillTo? billTo;
  final ShipTo? shipTo;

  const ApiContracts({
    required this.creditCard,
    required this.amount,
    required this.orderDetails,
    this.billTo,
    this.shipTo,
  });

  @override
  List<Object?> get props => [
    creditCard,
    amount,
    orderDetails,
    billTo,
    shipTo,
  ];

  @override
  String toString() => 'ApiContracts{creditCard: $creditCard, '
      'amount: $amount, '
      'orderDetails: $orderDetails, '
      'billTo: $billTo, '
      'shipTo: $shipTo}';
}

@immutable
class MerchantAuthentication extends Equatable {
  final String apiLoginKey;
  final String transactionKey;
  final String merchantId;

  const MerchantAuthentication({
    required this.apiLoginKey,
    required this.transactionKey,
    required this.merchantId,
  });

  @override
  List<Object?> get props => [
    apiLoginKey,
    transactionKey,
    merchantId,
  ];

  @override
  String toString() => 'MerchantAuthentication{apiLoginKey: $apiLoginKey, '
      'transactionKey: $transactionKey}, '
      'merchantId: $merchantId}';
}

@immutable
class AuthorizeGateWayService extends Equatable {
  final MerchantAuthentication merchantAuthentication;
  final ApiContracts apiContracts;

  const AuthorizeGateWayService({
    required this.merchantAuthentication,
    required this.apiContracts,
  });

  Future<CreditCardResponse> makePayment() async {
    apiContracts.orderDetails.invoiceNumber?.log();
    final response = await http.post(
      Uri.parse("https://api.authorize.net/xml/v1/request.api"), // test: https://apitest.authorize.net/xml/v1/request.api  // live: https://api.authorize.net/xml/v1/request.api
      body: jsonEncode(
        {
          "createTransactionRequest": {
            "merchantAuthentication": {
              "name": merchantAuthentication.apiLoginKey,
              "transactionKey": merchantAuthentication.transactionKey,
            },
            "refId": merchantAuthentication.merchantId,
            "transactionRequest": {
              "transactionType": "authCaptureTransaction",
              "amount": "${apiContracts.amount}",
              "payment": {
                "creditCard": {
                  "cardNumber":
                  apiContracts.creditCard.cardNumber.removeAllSpaces(),
                  "expirationDate": apiContracts.creditCard.expirationDate,
                  "cardCode": apiContracts.creditCard.cardCode
                }
              },
              "order": {
                "invoiceNumber":
                apiContracts.orderDetails.invoiceNumber?.trim(),
                "description": apiContracts.orderDetails.description?.trim(),
              },
            }
          }
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load");
    }

    final creditCardJson = jsonDecode(response.body) as Map;

    if (!creditCardJson.containsKey('messages')) {
      throw Exception("Failed to load");
    }

    final messages = creditCardJson['messages'] as Map;

    if (!messages.containsKey('resultCode')) {
      throw Exception("Failed to load");
    }

    final creditCardResponse = CreditCardResponse.fromJson(
      jsonDecode(response.body),
    );

    return creditCardResponse;
  }

  @override
  List<Object?> get props => [
    merchantAuthentication,
    apiContracts,
  ];
}

extension Logger on Object {
  void log() {
    developer.log(toString());
  }
}

extension RemoveAllSpaces on String {
  String removeAllSpaces() {
    return replaceAll(RegExp(r'\s+'), '');
  }
}
