// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardInfoImpl _$$CardInfoImplFromJson(Map<String, dynamic> json) =>
    _$CardInfoImpl(
      cardNumber: json['card_number'] as String?,
      cardHolderName: json['card_holder'] as String?,
      expirationDate: json['expiration_date'] as String?,
    );

Map<String, dynamic> _$$CardInfoImplToJson(_$CardInfoImpl instance) =>
    <String, dynamic>{
      'card_number': instance.cardNumber,
      'card_holder': instance.cardHolderName,
      'expiration_date': instance.expirationDate,
    };
