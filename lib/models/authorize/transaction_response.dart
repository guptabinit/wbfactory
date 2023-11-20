import 'package:json_annotation/json_annotation.dart';

part 'transaction_response.g.dart';

@JsonSerializable()
class TransactionResponse {
  final String? responseCode;
  final String? authCode;
  final String? avsResultCode;
  final String? cvvResultCode;
  final String? cavvResultCode;
  final String? transId;
  final String? refTransID;
  final String? transHash;
  final String? testRequest;
  final String? accountNumber;
  final String? accountType;
  final List<TransactionResponseError>? errors;
  final List<Message>? messages;
  final List<UserField>? userFields;
  final String? transHashSha2;
  @JsonKey(name: "SupplementalDataQualificationIndicator")
  final int? supplementalDataQualificationIndicator;
  final String? networkTransId;

  const TransactionResponse({
    this.responseCode,
    this.authCode,
    this.avsResultCode,
    this.cvvResultCode,
    this.cavvResultCode,
    this.transId,
    this.refTransID,
    this.transHash,
    this.testRequest,
    this.accountNumber,
    this.accountType,
    this.messages,
    this.userFields,
    this.transHashSha2,
    this.supplementalDataQualificationIndicator,
    this.networkTransId,
    this.errors,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);

  @override
  String toString() {
    return 'TransactionResponse(responseCode: $responseCode, '
        'authCode: $authCode, '
        'avsResultCode: $avsResultCode, '
        'cvvResultCode: $cvvResultCode, '
        'cavvResultCode: $cavvResultCode, '
        'transId: $transId, '
        'refTransID: $refTransID, '
        'transHash: $transHash, '
        'testRequest: $testRequest, '
        'accountNumber: $accountNumber, '
        'accountType: $accountType, '
        'messages: $messages, '
        'userFields: $userFields, '
        'transHashSha2: $transHashSha2, '
        'supplementalDataQualificationIndicator: $supplementalDataQualificationIndicator, '
        'networkTransId: $networkTransId, '
        'errors: $errors)';
  }
}

@JsonSerializable()
class Message {
  final String? code;
  final String? description;

  const Message({
    this.code,
    this.description,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  String toString() {
    return 'Message(code: $code, description: $description)';
  }
}

@JsonSerializable()
class UserField {
  final String? name;
  final String? value;

  const UserField({this.name, this.value});

  factory UserField.fromJson(Map<String, dynamic> json) =>
      _$UserFieldFromJson(json);

  Map<String, dynamic> toJson() => _$UserFieldToJson(this);

  @override
  String toString() {
    return 'UserField(name: $name, value: $value)';
  }
}

@JsonSerializable()
class TransactionResponseError {
  final String? errorCode;
  final String? errorText;

  const TransactionResponseError({this.errorCode, this.errorText});

  factory TransactionResponseError.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseErrorFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResponseErrorToJson(this);

  @override
  String toString() {
    return 'TransactionResponseError(errorCode: $errorCode, errorText: $errorText)';
  }
}
