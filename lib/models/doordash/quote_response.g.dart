// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteResponse _$QuoteResponseFromJson(Map<String, dynamic> json) =>
    QuoteResponse(
      externalDeliveryId: json['external_delivery_id'] as String?,
      locale: json['locale'] as String?,
      orderFulfillmentMethod: json['order_fulfillment_method'] as String?,
      originFacilityId: json['origin_facility_id'] as String?,
      pickupAddress: json['pickup_address'] as String?,
      pickupBusinessName: json['pickup_business_name'] as String?,
      pickupPhoneNumber: json['pickup_phone_number'] as String?,
      pickupInstructions: json['pickup_instructions'] as String?,
      pickupReferenceTag: json['pickup_reference_tag'] as String?,
      pickupExternalBusinessId: json['pickup_external_business_id'] as String?,
      pickupExternalStoreId: json['pickup_external_store_id'] as String?,
      dropoffAddress: json['dropoff_address'] as String?,
      dropoffBusinessName: json['dropoff_business_name'] as String?,
      dropoffLocation: json['dropoff_location'] == null
          ? null
          : DropoffLocation.fromJson(
              json['dropoff_location'] as Map<String, dynamic>),
      dropoffPhoneNumber: json['dropoff_phone_number'] as String?,
      dropoffInstructions: json['dropoff_instructions'] as String?,
      dropoffContactGivenName: json['dropoff_contact_given_name'] as String?,
      dropoffContactFamilyName: json['dropoff_contact_family_name'] as String?,
      dropoffContactSendNotifications:
          json['dropoff_contact_send_notifications'] as bool?,
      dropoffOptions: json['dropoff_options'] == null
          ? null
          : DropoffOptions.fromJson(
              json['dropoff_options'] as Map<String, dynamic>),
      orderValue: json['order_value'] as int?,
      currency: json['currency'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      shoppingOptions: json['shopping_options'] == null
          ? null
          : ShoppingOptions.fromJson(
              json['shopping_options'] as Map<String, dynamic>),
      deliveryStatus: json['delivery_status'] as String?,
      cancellationReason: json['cancellation_reason'] as String?,
      updatedAt: json['updated_at'] as String?,
      pickupTimeEstimated: json['pickup_time_estimated'] as String?,
      pickupTimeActual: json['pickup_time_actual'] as String?,
      dropoffTimeEstimated: json['dropoff_time_estimated'] as String?,
      dropoffTimeActual: json['dropoff_time_actual'] as String?,
      returnTimeEstimated: json['return_time_estimated'] as String?,
      returnTimeActual: json['return_time_actual'] as String?,
      returnAddress: json['return_address'] as String?,
      fee: (json['fee'] as num?)?.toDouble(),
      feeComponents: (json['fee_components'] as List<dynamic>?)
          ?.map((e) => FeeComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
      tax: (json['tax'] as num?)?.toDouble(),
      taxComponents: (json['tax_components'] as List<dynamic>?)
          ?.map((e) => FeeComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
      supportReference: json['support_reference'] as String?,
      trackingUrl: json['tracking_url'] as String?,
      dropoffVerificationImageUrl:
          json['dropoff_verification_image_url'] as String?,
      pickupVerificationImageUrl: json['pickup_signature_image_url'] as String?,
      dropoffSignatureImageUrl: json['dropoff_signature_image_url'] as String?,
      shippingLabel: json['shipping_label'] == null
          ? null
          : ShippingLabel.fromJson(
              json['shipping_label'] as Map<String, dynamic>),
      droppedItems: (json['dropped_items'] as List<dynamic>?)
          ?.map((e) => DroppedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      contactlessDropoff: json['contactless_dropoff'] as bool?,
      actionIfUndeliverable: json['action_if_undeliverable'] as String?,
      tip: (json['tip'] as num?)?.toDouble(),
      orderContains: json['order_contains'] == null
          ? null
          : OrderContains.fromJson(
              json['order_contains'] as Map<String, dynamic>),
      dasherAllowedVehicles: (json['dasher_allowed_vehicles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dropoffRequiresSignature: json['dropoff_requires_signature'] as bool?,
      promotionId: json['promotion_id'] as String?,
      dropoffCashOnDelivery:
          (json['dropoff_cash_on_delivery'] as num?)?.toDouble(),
      dasherId: json['dasher_id'] as int?,
      dasherName: json['dasher_name'] as String?,
      dasherDropoffPhoneNumber: json['dasher_dropoff_phone_number'] as String?,
      dasherPickupPhoneNumber: json['dasher_pickup_phone_number'] as String?,
      dasherLocation: json['dasher_location'] == null
          ? null
          : DasherLocation.fromJson(
              json['dasher_location'] as Map<String, dynamic>),
      dasherVehicleMake: json['dasher_vehicle_make'] as String?,
      dasherVehicleModel: json['dasher_vehicle_model'] as String?,
      dasherVehicleYear: json['dasher_vehicle_year'] as String?,
    );

Map<String, dynamic> _$QuoteResponseToJson(QuoteResponse instance) =>
    <String, dynamic>{
      'external_delivery_id': instance.externalDeliveryId,
      'locale': instance.locale,
      'order_fulfillment_method': instance.orderFulfillmentMethod,
      'origin_facility_id': instance.originFacilityId,
      'pickup_address': instance.pickupAddress,
      'pickup_business_name': instance.pickupBusinessName,
      'pickup_phone_number': instance.pickupPhoneNumber,
      'pickup_instructions': instance.pickupInstructions,
      'pickup_reference_tag': instance.pickupReferenceTag,
      'pickup_external_business_id': instance.pickupExternalBusinessId,
      'pickup_external_store_id': instance.pickupExternalStoreId,
      'dropoff_address': instance.dropoffAddress,
      'dropoff_business_name': instance.dropoffBusinessName,
      'dropoff_location': instance.dropoffLocation,
      'dropoff_phone_number': instance.dropoffPhoneNumber,
      'dropoff_instructions': instance.dropoffInstructions,
      'dropoff_contact_given_name': instance.dropoffContactGivenName,
      'dropoff_contact_family_name': instance.dropoffContactFamilyName,
      'dropoff_contact_send_notifications':
          instance.dropoffContactSendNotifications,
      'dropoff_options': instance.dropoffOptions,
      'order_value': instance.orderValue,
      'currency': instance.currency,
      'items': instance.items,
      'shopping_options': instance.shoppingOptions,
      'delivery_status': instance.deliveryStatus,
      'cancellation_reason': instance.cancellationReason,
      'updated_at': instance.updatedAt,
      'pickup_time_estimated': instance.pickupTimeEstimated,
      'pickup_time_actual': instance.pickupTimeActual,
      'dropoff_time_estimated': instance.dropoffTimeEstimated,
      'dropoff_time_actual': instance.dropoffTimeActual,
      'return_time_estimated': instance.returnTimeEstimated,
      'return_time_actual': instance.returnTimeActual,
      'return_address': instance.returnAddress,
      'fee': instance.fee,
      'fee_components': instance.feeComponents,
      'tax': instance.tax,
      'tax_components': instance.taxComponents,
      'support_reference': instance.supportReference,
      'tracking_url': instance.trackingUrl,
      'dropoff_verification_image_url': instance.dropoffVerificationImageUrl,
      'pickup_signature_image_url': instance.pickupVerificationImageUrl,
      'dropoff_signature_image_url': instance.dropoffSignatureImageUrl,
      'shipping_label': instance.shippingLabel,
      'dropped_items': instance.droppedItems,
      'contactless_dropoff': instance.contactlessDropoff,
      'action_if_undeliverable': instance.actionIfUndeliverable,
      'tip': instance.tip,
      'order_contains': instance.orderContains,
      'dasher_allowed_vehicles': instance.dasherAllowedVehicles,
      'dropoff_requires_signature': instance.dropoffRequiresSignature,
      'promotion_id': instance.promotionId,
      'dropoff_cash_on_delivery': instance.dropoffCashOnDelivery,
      'dasher_id': instance.dasherId,
      'dasher_name': instance.dasherName,
      'dasher_dropoff_phone_number': instance.dasherDropoffPhoneNumber,
      'dasher_pickup_phone_number': instance.dasherPickupPhoneNumber,
      'dasher_location': instance.dasherLocation,
      'dasher_vehicle_make': instance.dasherVehicleMake,
      'dasher_vehicle_model': instance.dasherVehicleModel,
      'dasher_vehicle_year': instance.dasherVehicleYear,
    };

DropoffLocation _$DropoffLocationFromJson(Map<String, dynamic> json) =>
    DropoffLocation(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DropoffLocationToJson(DropoffLocation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

DropoffOptions _$DropoffOptionsFromJson(Map<String, dynamic> json) =>
    DropoffOptions(
      signature: json['signature'] as String?,
      idVerification: json['id_verification'] as String?,
      proofOfDelivery: json['proof_of_delivery'] as String?,
    );

Map<String, dynamic> _$DropoffOptionsToJson(DropoffOptions instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'id_verification': instance.idVerification,
      'proof_of_delivery': instance.proofOfDelivery,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      name: json['name'] as String?,
      description: json['description'] as String?,
      quantity: json['quantity'] as int?,
      externalId: json['external_id'] as String?,
      externalInstanceId: json['external_instance_id'] as int?,
      volume: (json['volume'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      barcode: json['barcode'] as int?,
      itemOptions: json['item_options'] == null
          ? null
          : ItemOptions.fromJson(json['item_options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'quantity': instance.quantity,
      'external_id': instance.externalId,
      'external_instance_id': instance.externalInstanceId,
      'volume': instance.volume,
      'weight': instance.weight,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
      'price': instance.price,
      'barcode': instance.barcode,
      'item_options': instance.itemOptions,
    };

ItemOptions _$ItemOptionsFromJson(Map<String, dynamic> json) => ItemOptions(
      substituteItemIds: (json['substitute_item_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      weightUnit: json['weight_unit'] as String?,
      substitutionPreference: json['substitution_preference'] as String?,
    );

Map<String, dynamic> _$ItemOptionsToJson(ItemOptions instance) =>
    <String, dynamic>{
      'substitute_item_ids': instance.substituteItemIds,
      'weight_unit': instance.weightUnit,
      'substitution_preference': instance.substitutionPreference,
    };

ShoppingOptions _$ShoppingOptionsFromJson(Map<String, dynamic> json) =>
    ShoppingOptions(
      paymentMethod: json['payment_method'] as String?,
      paymentBarcode: json['payment_barcode'] as String?,
      paymentGiftCards: (json['payment_gift_cards'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      readyForPickupBy: json['ready_for_pickup_by'] as String?,
      dropoffContactLoyaltyNumber:
          json['dropoff_contact_loyalty_number'] as String?,
    );

Map<String, dynamic> _$ShoppingOptionsToJson(ShoppingOptions instance) =>
    <String, dynamic>{
      'payment_method': instance.paymentMethod,
      'payment_barcode': instance.paymentBarcode,
      'payment_gift_cards': instance.paymentGiftCards,
      'ready_for_pickup_by': instance.readyForPickupBy,
      'dropoff_contact_loyalty_number': instance.dropoffContactLoyaltyNumber,
    };

FeeComponent _$FeeComponentFromJson(Map<String, dynamic> json) => FeeComponent(
      type: json['type'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FeeComponentToJson(FeeComponent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'amount': instance.amount,
    };

TaxComponent _$TaxComponentFromJson(Map<String, dynamic> json) => TaxComponent(
      type: json['type'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TaxComponentToJson(TaxComponent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'amount': instance.amount,
    };

ShippingLabel _$ShippingLabelFromJson(Map<String, dynamic> json) =>
    ShippingLabel(
      labelFormat: json['label_format'] as String?,
      labelSize: json['label_size'] as String?,
      printDensity: json['print_density'] as String?,
      labelString: json['label_string'] as String?,
    );

Map<String, dynamic> _$ShippingLabelToJson(ShippingLabel instance) =>
    <String, dynamic>{
      'label_format': instance.labelFormat,
      'label_size': instance.labelSize,
      'print_density': instance.printDensity,
      'label_string': instance.labelString,
    };

DroppedItem _$DroppedItemFromJson(Map<String, dynamic> json) => DroppedItem(
      externalId: json['external_id'] as String?,
      type: json['type'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$DroppedItemToJson(DroppedItem instance) =>
    <String, dynamic>{
      'external_id': instance.externalId,
      'type': instance.type,
      'reason': instance.reason,
    };

OrderContains _$OrderContainsFromJson(Map<String, dynamic> json) =>
    OrderContains(
      alcohol: json['alcohol'] as bool?,
    );

Map<String, dynamic> _$OrderContainsToJson(OrderContains instance) =>
    <String, dynamic>{
      'alcohol': instance.alcohol,
    };

DasherLocation _$DasherLocationFromJson(Map<String, dynamic> json) =>
    DasherLocation(
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
    );

Map<String, dynamic> _$DasherLocationToJson(DasherLocation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
