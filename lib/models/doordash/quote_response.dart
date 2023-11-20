import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote_response.g.dart';

@JsonSerializable()
class QuoteResponse extends Equatable {
  @JsonKey(name: "external_delivery_id")
  final String? externalDeliveryId;
  final String? locale;
  @JsonKey(name: "order_fulfillment_method")
  final String? orderFulfillmentMethod;
  @JsonKey(name: 'origin_facility_id')
  final String? originFacilityId;
  @JsonKey(name: 'pickup_address')
  final String? pickupAddress;
  @JsonKey(name: 'pickup_business_name')
  final String? pickupBusinessName;
  @JsonKey(name: 'pickup_phone_number')
  final String? pickupPhoneNumber;
  @JsonKey(name: 'pickup_instructions')
  final String? pickupInstructions;
  @JsonKey(name: 'pickup_reference_tag')
  final String? pickupReferenceTag;
  @JsonKey(name: 'pickup_external_business_id')
  final String? pickupExternalBusinessId;
  @JsonKey(name: 'pickup_external_store_id')
  final String? pickupExternalStoreId;
  @JsonKey(name: 'dropoff_address')
  final String? dropoffAddress;
  @JsonKey(name: 'dropoff_business_name')
  final String? dropoffBusinessName;
  @JsonKey(name: 'dropoff_location')
  final DropoffLocation? dropoffLocation;
  @JsonKey(name: 'dropoff_phone_number')
  final String? dropoffPhoneNumber;
  @JsonKey(name: 'dropoff_instructions')
  final String? dropoffInstructions;
  @JsonKey(name: 'dropoff_contact_given_name')
  final String? dropoffContactGivenName;
  @JsonKey(name: 'dropoff_contact_family_name')
  final String? dropoffContactFamilyName;
  @JsonKey(name: 'dropoff_contact_send_notifications')
  final bool? dropoffContactSendNotifications;
  @JsonKey(name: 'dropoff_options')
  final DropoffOptions? dropoffOptions;
  @JsonKey(name: 'order_value')
  final int? orderValue;
  final String? currency;
  final List<Item>? items;
  @JsonKey(name: 'shopping_options')
  final ShoppingOptions? shoppingOptions;
  @JsonKey(name: 'delivery_status')
  final String? deliveryStatus;
  @JsonKey(name: 'cancellation_reason')
  final String? cancellationReason;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'pickup_time_estimated')
  final String? pickupTimeEstimated;
  @JsonKey(name: 'pickup_time_actual')
  final String? pickupTimeActual;
  @JsonKey(name: 'dropoff_time_estimated')
  final String? dropoffTimeEstimated;
  @JsonKey(name: 'dropoff_time_actual')
  final String? dropoffTimeActual;
  @JsonKey(name: 'return_time_estimated')
  final String? returnTimeEstimated;
  @JsonKey(name: 'return_time_actual')
  final String? returnTimeActual;
  @JsonKey(name: 'return_address')
  final String? returnAddress;
  final double? fee;
  @JsonKey(name: 'fee_components')
  final List<FeeComponent>? feeComponents;
  final double? tax;
  @JsonKey(name: 'tax_components')
  final List<FeeComponent>? taxComponents;
  @JsonKey(name: 'support_reference')
  final String? supportReference;
  @JsonKey(name: 'tracking_url')
  final String? trackingUrl;
  @JsonKey(name: 'dropoff_verification_image_url')
  final String? dropoffVerificationImageUrl;
  @JsonKey(name: 'pickup_signature_image_url')
  final String? pickupVerificationImageUrl;
  @JsonKey(name: 'dropoff_signature_image_url')
  final String? dropoffSignatureImageUrl;
  @JsonKey(name: 'shipping_label')
  final ShippingLabel? shippingLabel;
  @JsonKey(name: 'dropped_items')
  final List<DroppedItem>? droppedItems;
  @JsonKey(name: "contactless_dropoff")
  final bool? contactlessDropoff;
  @JsonKey(name: "action_if_undeliverable")
  final String? actionIfUndeliverable;
  final double? tip;
  @JsonKey(name: 'order_contains')
  final OrderContains? orderContains;
  @JsonKey(name: 'dasher_allowed_vehicles')
  final List<String>? dasherAllowedVehicles;
  @JsonKey(name: 'dropoff_requires_signature')
  final bool? dropoffRequiresSignature;
  @JsonKey(name: 'promotion_id')
  final String? promotionId;
  @JsonKey(name: 'dropoff_cash_on_delivery')
  final double? dropoffCashOnDelivery;
  @JsonKey(name: 'dasher_id')
  final int? dasherId;
  @JsonKey(name: 'dasher_name')
  final String? dasherName;
  @JsonKey(name: 'dasher_dropoff_phone_number')
  final String? dasherDropoffPhoneNumber;
  @JsonKey(name: 'dasher_pickup_phone_number')
  final String? dasherPickupPhoneNumber;
  @JsonKey(name: 'dasher_location')
  final DasherLocation? dasherLocation;
  @JsonKey(name: 'dasher_vehicle_make')
  final String? dasherVehicleMake;
  @JsonKey(name: 'dasher_vehicle_model')
  final String? dasherVehicleModel;
  @JsonKey(name: 'dasher_vehicle_year')
  final String? dasherVehicleYear;

  const QuoteResponse({
    this.externalDeliveryId,
    this.locale,
    this.orderFulfillmentMethod,
    this.originFacilityId,
    this.pickupAddress,
    this.pickupBusinessName,
    this.pickupPhoneNumber,
    this.pickupInstructions,
    this.pickupReferenceTag,
    this.pickupExternalBusinessId,
    this.pickupExternalStoreId,
    this.dropoffAddress,
    this.dropoffBusinessName,
    this.dropoffLocation,
    this.dropoffPhoneNumber,
    this.dropoffInstructions,
    this.dropoffContactGivenName,
    this.dropoffContactFamilyName,
    this.dropoffContactSendNotifications,
    this.dropoffOptions,
    this.orderValue,
    this.currency,
    this.items,
    this.shoppingOptions,
    this.deliveryStatus,
    this.cancellationReason,
    this.updatedAt,
    this.pickupTimeEstimated,
    this.pickupTimeActual,
    this.dropoffTimeEstimated,
    this.dropoffTimeActual,
    this.returnTimeEstimated,
    this.returnTimeActual,
    this.returnAddress,
    this.fee,
    this.feeComponents,
    this.tax,
    this.taxComponents,
    this.supportReference,
    this.trackingUrl,
    this.dropoffVerificationImageUrl,
    this.pickupVerificationImageUrl,
    this.dropoffSignatureImageUrl,
    this.shippingLabel,
    this.droppedItems,
    this.contactlessDropoff,
    this.actionIfUndeliverable,
    this.tip,
    this.orderContains,
    this.dasherAllowedVehicles,
    this.dropoffRequiresSignature,
    this.promotionId,
    this.dropoffCashOnDelivery,
    this.dasherId,
    this.dasherName,
    this.dasherDropoffPhoneNumber,
    this.dasherPickupPhoneNumber,
    this.dasherLocation,
    this.dasherVehicleMake,
    this.dasherVehicleModel,
    this.dasherVehicleYear,
  });

  factory QuoteResponse.fromJson(Map<String, dynamic> json) =>
      _$QuoteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteResponseToJson(this);

  @override
  String toString() => 'QuoteResponse{externalDeliveryId: $externalDeliveryId, '
      'locale: $locale, '
      'orderFulfillmentMethod: $orderFulfillmentMethod, '
      'originFacilityId: $originFacilityId, '
      'pickupAddress: $pickupAddress, '
      'pickupBusinessName: $pickupBusinessName, '
      'pickupPhoneNumber: $pickupPhoneNumber, '
      'pickupInstructions: $pickupInstructions, '
      'pickupReferenceTag: $pickupReferenceTag, '
      'pickupExternalBusinessId: $pickupExternalBusinessId, '
      'pickupExternalStoreId: $pickupExternalStoreId, '
      'dropoffAddress: $dropoffAddress, '
      'dropoffBusinessName: $dropoffBusinessName, '
      'dropoffLocation: $dropoffLocation, '
      'dropoffPhoneNumber: $dropoffPhoneNumber, '
      'dropoffInstructions: $dropoffInstructions, '
      'dropoffContactGivenName: $dropoffContactGivenName, '
      'dropoffContactFamilyName: $dropoffContactFamilyName, '
      'dropoffContactSendNotifications: $dropoffContactSendNotifications, '
      'dropoffOptions: $dropoffOptions, '
      'orderValue: $orderValue, '
      'currency: $currency, '
      'items: $items, '
      'shoppingOptions: $shoppingOptions, '
      'deliveryStatus: $deliveryStatus, '
      'cancellationReason: $cancellationReason, '
      'updatedAt: $updatedAt, '
      'pickupTimeEstimated: $pickupTimeEstimated, '
      'pickupTimeActual: $pickupTimeActual, '
      'dropoffTimeEstimated: $dropoffTimeEstimated, '
      'dropoffTimeActual: $dropoffTimeActual, '
      'returnTimeEstimated: $returnTimeEstimated, '
      'returnTimeActual: $returnTimeActual, '
      'returnAddress: $returnAddress, '
      'fee: $fee, '
      'feeComponents: $feeComponents, '
      'tax: $tax, '
      'taxComponents: $taxComponents, '
      'supportReference: $supportReference, '
      'trackingUrl: $trackingUrl, '
      'dropoffVerificationImageUrl: $dropoffVerificationImageUrl, '
      'pickupVerificationImageUrl: $pickupVerificationImageUrl, '
      'dropoffSignatureImageUrl: $dropoffSignatureImageUrl, '
      'shippingLabel: $shippingLabel, '
      'droppedItems: $droppedItems, '
      'contactlessDropoff: $contactlessDropoff, '
      'actionIfUndeliverable: $actionIfUndeliverable, '
      'tip: $tip, '
      'orderContains: $orderContains, '
      'dasherAllowedVehicles: $dasherAllowedVehicles, '
      'dropoffRequiresSignature: $dropoffRequiresSignature, '
      'promotionId: $promotionId, '
      'dasherId: $dasherId, '
      'dasherName: $dasherName, '
      'dasherDropoffPhoneNumber: $dasherDropoffPhoneNumber, '
      'dasherPickupPhoneNumber: $dasherPickupPhoneNumber, '
      'dasherLocation: $dasherLocation, '
      'dasherVehicleMake: $dasherVehicleMake, '
      'dasherVehicleModel: $dasherVehicleModel, '
      'dasherVehicleYear: $dasherVehicleYear}';

  @override
  List<Object?> get props => [
    externalDeliveryId,
    locale,
    orderFulfillmentMethod,
    originFacilityId,
    pickupAddress,
    pickupBusinessName,
    pickupPhoneNumber,
    pickupInstructions,
    pickupReferenceTag,
    pickupExternalBusinessId,
    pickupExternalStoreId,
    dropoffAddress,
    dropoffBusinessName,
    dropoffLocation,
    dropoffPhoneNumber,
    dropoffInstructions,
    dropoffContactGivenName,
    dropoffContactFamilyName,
    dropoffContactSendNotifications,
    dropoffOptions,
    orderValue,
    currency,
    items,
    shoppingOptions,
    deliveryStatus,
    cancellationReason,
    updatedAt,
    pickupTimeEstimated,
    pickupTimeActual,
    dropoffTimeEstimated,
    dropoffTimeActual,
    returnTimeEstimated,
    returnTimeActual,
    returnAddress,
    fee,
    feeComponents,
    tax,
    taxComponents,
    supportReference,
    trackingUrl,
    dropoffVerificationImageUrl,
    pickupVerificationImageUrl,
    dropoffSignatureImageUrl,
    shippingLabel,
    droppedItems,
    contactlessDropoff,
    actionIfUndeliverable,
    tip,
    orderContains,
    dasherAllowedVehicles,
    dropoffRequiresSignature,
    promotionId,
    dasherId,
    dasherName,
    dasherDropoffPhoneNumber,
    dasherPickupPhoneNumber,
    dasherLocation,
    dasherVehicleMake,
    dasherVehicleModel,
    dasherVehicleYear,
  ];
}

@JsonSerializable()
class DropoffLocation extends Equatable {
  final double? lat;
  final double? lng;

  const DropoffLocation({this.lat, this.lng});

  factory DropoffLocation.fromJson(Map<String, dynamic> json) =>
      _$DropoffLocationFromJson(json);

  Map<String, dynamic> toJson() => _$DropoffLocationToJson(this);

  @override
  String toString() => 'DropoffLocation{lat: $lat, lng: $lng}';

  @override
  List<Object?> get props => [
    lat,
    lng,
  ];
}

@JsonSerializable()
class DropoffOptions extends Equatable {
  final String? signature;
  @JsonKey(name: "id_verification")
  final String? idVerification;
  @JsonKey(name: "proof_of_delivery")
  final String? proofOfDelivery;

  const DropoffOptions({
    this.signature,
    this.idVerification,
    this.proofOfDelivery,
  });

  factory DropoffOptions.fromJson(Map<String, dynamic> json) =>
      _$DropoffOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$DropoffOptionsToJson(this);

  @override
  String toString() => 'DropoffOptions{signature: $signature, '
      'idVerification: $idVerification, '
      'proofOfDelivery: $proofOfDelivery}';

  @override
  List<Object?> get props => [
    signature,
    idVerification,
    proofOfDelivery,
  ];
}

@JsonSerializable()
class Item extends Equatable {
  final String? name;
  final String? description;
  final int? quantity;
  @JsonKey(name: 'external_id')
  final String? externalId;
  @JsonKey(name: 'external_instance_id')
  final int? externalInstanceId;
  final double? volume;
  final double? weight;
  final double? length;
  final double? width;
  final double? height;
  final double? price;
  final int? barcode;
  @JsonKey(name: 'item_options')
  final ItemOptions? itemOptions;

  const Item({
    this.name,
    this.description,
    this.quantity,
    this.externalId,
    this.externalInstanceId,
    this.volume,
    this.weight,
    this.length,
    this.width,
    this.height,
    this.price,
    this.barcode,
    this.itemOptions,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  String toString() => 'Item{name: $name, '
      'description: $description, '
      'quantity: $quantity, '
      'externalId: $externalId, '
      'externalInstanceId: $externalInstanceId, '
      'volume: $volume, '
      'weight: $weight, '
      'length: $length, '
      'width: $width, '
      'height: $height, '
      'price: $price, '
      'barcode: $barcode, '
      'itemOptions: $itemOptions}';

  @override
  List<Object?> get props => [
    name,
    description,
    quantity,
    externalId,
    externalInstanceId,
    volume,
    weight,
    length,
    width,
    height,
    price,
    barcode,
    itemOptions,
  ];
}

@JsonSerializable()
class ItemOptions extends Equatable {
  @JsonKey(name: "substitute_item_ids")
  final List<String>? substituteItemIds;
  @JsonKey(name: "weight_unit")
  final String? weightUnit;
  @JsonKey(name: "substitution_preference")
  final String? substitutionPreference;

  const ItemOptions({
    this.substituteItemIds,
    this.weightUnit,
    this.substitutionPreference,
  });

  factory ItemOptions.fromJson(Map<String, dynamic> json) =>
      _$ItemOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemOptionsToJson(this);

  @override
  String toString() => 'ItemOptions{substituteItemIds: $substituteItemIds, '
      'weightUnit: $weightUnit, '
      'substitutionPreference: $substitutionPreference}';

  @override
  List<Object?> get props => [
    substituteItemIds,
    weightUnit,
    substitutionPreference,
  ];
}

@JsonSerializable()
class ShoppingOptions extends Equatable {
  @JsonKey(name: "payment_method")
  final String? paymentMethod;
  @JsonKey(name: "payment_barcode")
  final String? paymentBarcode;
  @JsonKey(name: "payment_gift_cards")
  final List<String>? paymentGiftCards;
  @JsonKey(name: "ready_for_pickup_by")
  final String? readyForPickupBy;
  @JsonKey(name: "dropoff_contact_loyalty_number")
  final String? dropoffContactLoyaltyNumber;

  const ShoppingOptions({
    this.paymentMethod,
    this.paymentBarcode,
    this.paymentGiftCards,
    this.readyForPickupBy,
    this.dropoffContactLoyaltyNumber,
  });

  factory ShoppingOptions.fromJson(Map<String, dynamic> json) =>
      _$ShoppingOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingOptionsToJson(this);

  @override
  List<Object?> get props => [
    paymentMethod,
    paymentBarcode,
    paymentGiftCards,
    readyForPickupBy,
    dropoffContactLoyaltyNumber,
  ];
}

@JsonSerializable()
class FeeComponent extends Equatable {
  final String? type;
  final double? amount;

  const FeeComponent({
    this.type,
    this.amount,
  });

  factory FeeComponent.fromJson(Map<String, dynamic> json) =>
      _$FeeComponentFromJson(json);

  Map<String, dynamic> toJson() => _$FeeComponentToJson(this);

  @override
  String toString() => 'FeeComponent{type: $type, amount: $amount}';

  @override
  List<Object?> get props => [
    type,
    amount,
  ];
}

@JsonSerializable()
class TaxComponent extends Equatable {
  final String? type;
  final double? amount;

  const TaxComponent({
    this.type,
    this.amount,
  });

  factory TaxComponent.fromJson(Map<String, dynamic> json) =>
      _$TaxComponentFromJson(json);

  Map<String, dynamic> toJson() => _$TaxComponentToJson(this);

  @override
  String toString() => 'TaxComponent{type: $type, amount: $amount}';

  @override
  List<Object?> get props => [
    type,
    amount,
  ];
}

@JsonSerializable()
class ShippingLabel extends Equatable {
  @JsonKey(name: "label_format")
  final String? labelFormat;
  @JsonKey(name: "label_size")
  final String? labelSize;
  @JsonKey(name: "print_density")
  final String? printDensity;
  @JsonKey(name: "label_string")
  final String? labelString;

  const ShippingLabel({
    this.labelFormat,
    this.labelSize,
    this.printDensity,
    this.labelString,
  });

  factory ShippingLabel.fromJson(Map<String, dynamic> json) =>
      _$ShippingLabelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingLabelToJson(this);

  @override
  String toString() => 'ShippingLabel{labelFormat: $labelFormat, '
      'labelSize: $labelSize, '
      'printDensity: $printDensity, '
      'labelString: $labelString}';

  @override
  List<Object?> get props => [
    labelFormat,
    labelSize,
    printDensity,
    labelString,
  ];
}

@JsonSerializable()
class DroppedItem extends Equatable {
  @JsonKey(name: "external_id")
  final String? externalId;
  final String? type;
  final String? reason;

  const DroppedItem({
    this.externalId,
    this.type,
    this.reason,
  });

  factory DroppedItem.fromJson(Map<String, dynamic> json) =>
      _$DroppedItemFromJson(json);

  Map<String, dynamic> toJson() => _$DroppedItemToJson(this);

  @override
  String toString() => 'DroppedItem{externalId: $externalId, '
      'type: $type, '
      'reason: $reason}';

  @override
  List<Object?> get props => [
    externalId,
    type,
    reason,
  ];
}

@JsonSerializable()
class OrderContains extends Equatable {
  final bool? alcohol;

  const OrderContains({this.alcohol});

  factory OrderContains.fromJson(Map<String, dynamic> json) =>
      _$OrderContainsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderContainsToJson(this);

  @override
  String toString() => 'OrderContains{alcohol: $alcohol}';

  @override
  List<Object?> get props => [alcohol];
}

@JsonSerializable()
class DasherLocation extends Equatable {
  final String? lat;
  final String? lng;

  const DasherLocation({
    this.lat,
    this.lng,
  });

  factory DasherLocation.fromJson(Map<String, dynamic> json) =>
      _$DasherLocationFromJson(json);

  Map<String, dynamic> toJson() => _$DasherLocationToJson(this);

  @override
  String toString() => 'DasherLocation{lat: $lat, lng: $lng}';

  @override
  List<Object?> get props => [
    lat,
    lng,
  ];
}
