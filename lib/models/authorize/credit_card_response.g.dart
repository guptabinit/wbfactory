// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardResponse _$CreditCardResponseFromJson(Map<String, dynamic> json) =>
    CreditCardResponse(
      transactionResponse: json['transactionResponse'] == null
          ? null
          : TransactionResponse.fromJson(
              json['transactionResponse'] as Map<String, dynamic>),
      refId: json['refId'] as String?,
      messages: json['messages'] == null
          ? null
          : Messages.fromJson(json['messages'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreditCardResponseToJson(CreditCardResponse instance) =>
    <String, dynamic>{
      'transactionResponse': instance.transactionResponse,
      'refId': instance.refId,
      'messages': instance.messages,
    };

Messages _$MessagesFromJson(Map<String, dynamic> json) => Messages(
      resultCode: json['resultCode'] as String?,
      message: (json['message'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
      'resultCode': instance.resultCode,
      'message': instance.message,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      code: json['code'] as String?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'code': instance.code,
      'text': instance.text,
    };
