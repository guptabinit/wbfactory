import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_info.freezed.dart';
part 'card_info.g.dart';

@freezed
class CardInfo with _$CardInfo {
  const factory CardInfo({
    @JsonKey(name: 'card_number') String? cardNumber,
    @JsonKey(name: 'card_holder') String? cardHolderName,
    @JsonKey(name: 'expiration_date') String? expirationDate,
  }) = _CardInfo;

  factory CardInfo.fromJson(Map<String, dynamic> json) =>
      _$CardInfoFromJson(json);
}
