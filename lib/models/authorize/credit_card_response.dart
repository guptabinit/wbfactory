import 'package:json_annotation/json_annotation.dart';

import 'transaction_response.dart';

part 'credit_card_response.g.dart';

@JsonSerializable()
class CreditCardResponse {
  final TransactionResponse? transactionResponse;
  final String? refId;
  final Messages? messages;

  CreditCardResponse({this.transactionResponse, this.refId, this.messages});

  factory CreditCardResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditCardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardResponseToJson(this);

  @override
  String toString() {
    return 'CreditCardResponse(transactionResponse: $transactionResponse, '
        'refId: $refId, '
        'messages: $messages)';
  }
}

@JsonSerializable()
class Messages {
  final String? resultCode;
  final List<Message>? message;

  Messages({this.resultCode, this.message});

  factory Messages.fromJson(Map<String, dynamic> json) =>
      _$MessagesFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesToJson(this);

  @override
  String toString() {
    return 'Messages(resultCode: $resultCode, '
        'message: $message)';
  }
}

@JsonSerializable()
class Message {
  final String? code;
  final String? text;

  Message({this.code, this.text});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  String toString() {
    return 'Message(code: $code, '
        'text: $text)';
  }
}
