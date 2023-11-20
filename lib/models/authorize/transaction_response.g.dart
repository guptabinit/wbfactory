// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    TransactionResponse(
      responseCode: json['responseCode'] as String?,
      authCode: json['authCode'] as String?,
      avsResultCode: json['avsResultCode'] as String?,
      cvvResultCode: json['cvvResultCode'] as String?,
      cavvResultCode: json['cavvResultCode'] as String?,
      transId: json['transId'] as String?,
      refTransID: json['refTransID'] as String?,
      transHash: json['transHash'] as String?,
      testRequest: json['testRequest'] as String?,
      accountNumber: json['accountNumber'] as String?,
      accountType: json['accountType'] as String?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      userFields: (json['userFields'] as List<dynamic>?)
          ?.map((e) => UserField.fromJson(e as Map<String, dynamic>))
          .toList(),
      transHashSha2: json['transHashSha2'] as String?,
      supplementalDataQualificationIndicator:
          json['SupplementalDataQualificationIndicator'] as int?,
      networkTransId: json['networkTransId'] as String?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) =>
              TransactionResponseError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionResponseToJson(
        TransactionResponse instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'authCode': instance.authCode,
      'avsResultCode': instance.avsResultCode,
      'cvvResultCode': instance.cvvResultCode,
      'cavvResultCode': instance.cavvResultCode,
      'transId': instance.transId,
      'refTransID': instance.refTransID,
      'transHash': instance.transHash,
      'testRequest': instance.testRequest,
      'accountNumber': instance.accountNumber,
      'accountType': instance.accountType,
      'errors': instance.errors,
      'messages': instance.messages,
      'userFields': instance.userFields,
      'transHashSha2': instance.transHashSha2,
      'SupplementalDataQualificationIndicator':
          instance.supplementalDataQualificationIndicator,
      'networkTransId': instance.networkTransId,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      code: json['code'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
    };

UserField _$UserFieldFromJson(Map<String, dynamic> json) => UserField(
      name: json['name'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$UserFieldToJson(UserField instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

TransactionResponseError _$TransactionResponseErrorFromJson(
        Map<String, dynamic> json) =>
    TransactionResponseError(
      errorCode: json['errorCode'] as String?,
      errorText: json['errorText'] as String?,
    );

Map<String, dynamic> _$TransactionResponseErrorToJson(
        TransactionResponseError instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorText': instance.errorText,
    };
