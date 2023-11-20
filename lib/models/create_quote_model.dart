import '../data/store_address.dart';

class CreateQuoteModel {
  // final String externalDeliveryID;
  final String dropoffAddress;
  final String dropoffBusinessName;
  final Map<String, double> dropoffLocation;
  final String dropoffPhoneNumber;
  final String dropoffContactName;
  final int orderValue;
  // final String pickupTime;

  CreateQuoteModel({
    // required this.externalDeliveryID,
    required this.dropoffAddress,
    required this.dropoffBusinessName,
    required this.dropoffLocation,
    required this.dropoffPhoneNumber,
    required this.dropoffContactName,
    required this.orderValue,
    // required this.pickupTime,
  });

  Map<String, dynamic> toJson() => {
    // "external_delivery_id": externalDeliveryID,
    "locale": "en-US",
    "order_fulfillment_method": orderFulfillmentID,
    "pickup_address": pickupAddress,
    "pickup_business_name": pickupBusinessName,
    "pickup_phone_number": pickupPhoneNumber,
    "pickup_instructions": pickupInstruction,
    "dropoff_address": dropoffAddress,
    "dropoff_business_name": dropoffBusinessName,
    "dropoff_location": dropoffLocation,
    "dropoff_phone_number": dropoffPhoneNumber,
    "dropoff_contact_given_name": dropoffContactName,
    "dropoff_contact_send_notifications": true,
    "contactless_dropoff": false,
    "order_value": orderValue,
    // "pickup_time": pickupTime,
    "action_if_undeliverable": "return_to_pickup",
    "order_contains": {"alcohol": false}
  };
}
