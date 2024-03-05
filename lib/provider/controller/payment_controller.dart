import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/authorize/credit_card_response.dart';
import '../../resources/authorize_gateway_service.dart';

enum Status {
  init,
  loading,
  success,
  error,
}

class PaymentController extends GetxController {
  final _status = Status.init.obs;
  final _error = "".obs;
  final _describedError = "".obs;
  final _successMessage = "".obs;
  final _creditCardResponse = Rxn(CreditCardResponse());

  Rx<Status> get status => _status;

  Rx<String> get error => _error;

  Rx<String> get describedError => _describedError;

  Rx<String> get successMessage => _successMessage;

  Rxn<CreditCardResponse> get creditCardResponse => _creditCardResponse;

  Future<void> makePayment(ApiContracts contracts) async {
    _status.value = Status.loading;
    try {
      _error.value = '';
      _describedError.value = '';
      _successMessage.value = '';

      // Get.defaultDialog(
      //   title: 'Payment in progress',
      //   middleText:
      //       'Please wait while we process your payment, don\'t close this window',
      //   barrierDismissible: false,
      // );

      final gateway = AuthorizeGateWayService(
        merchantAuthentication: merchantAuthentication,
        apiContracts: contracts,
      );

      final result = await gateway.makePayment();

      result.log();

      if (result.transactionResponse?.responseCode == '1') {
        _creditCardResponse.value = result;
        _status.value = Status.success;
        _error.value = '';
        _successMessage.value = result.transactionResponse?.messages
                ?.map((e) => e.description)
                .join(" ") ??
            "";

        // if (Get.isDialogOpen == true) {
        //   Get.back(closeOverlays: true);
        // }

        // Get.back();

        Get.snackbar(
          "Payment Successful",
          _successMessage.value,
          colorText: const Color(0xFFFFFFFF),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        );
      } else {
        _status.value = Status.error;
        _error.value = result.transactionResponse?.errors
                ?.map((e) => e.errorText)
                .join(" ") ??
            result.messages?.message?.map((e) => e.text).join(' ') ??
            "";
        _successMessage.value = "";

        // if (Get.isDialogOpen == true) {
        //   Get.back(closeOverlays: true);
        // }

        // Get.back();

        Get.snackbar(
          "Payment Error",
          error.value,
          colorText: const Color(0xFFFFFFFF),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFF44336),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        );
      }
    } catch (e) {
      _status.value = Status.error;
      _error.value = e.toString();
    }
  }

  final merchantAuthentication = const MerchantAuthentication(
    apiLoginKey: '699xCpTny',
    // Live: 699xCpTny // Test: 5KP3u95bQpv
    transactionKey: '7VNj6ynF95986H3D',
    // Live: 7VNj6ynF95986H3D // Test: 346HZ32z3fP4hTG2
    merchantId: '9011480', // Live: 9011480 // Test: 123456
  );
}
