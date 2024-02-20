// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CardInfo _$CardInfoFromJson(Map<String, dynamic> json) {
  return _CardInfo.fromJson(json);
}

/// @nodoc
mixin _$CardInfo {
  @JsonKey(name: 'card_number')
  String? get cardNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'card_holder')
  String? get cardHolderName => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiration_date')
  String? get expirationDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CardInfoCopyWith<CardInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardInfoCopyWith<$Res> {
  factory $CardInfoCopyWith(CardInfo value, $Res Function(CardInfo) then) =
      _$CardInfoCopyWithImpl<$Res, CardInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'card_number') String? cardNumber,
      @JsonKey(name: 'card_holder') String? cardHolderName,
      @JsonKey(name: 'expiration_date') String? expirationDate});
}

/// @nodoc
class _$CardInfoCopyWithImpl<$Res, $Val extends CardInfo>
    implements $CardInfoCopyWith<$Res> {
  _$CardInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardNumber = freezed,
    Object? cardHolderName = freezed,
    Object? expirationDate = freezed,
  }) {
    return _then(_value.copyWith(
      cardNumber: freezed == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      cardHolderName: freezed == cardHolderName
          ? _value.cardHolderName
          : cardHolderName // ignore: cast_nullable_to_non_nullable
              as String?,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CardInfoImplCopyWith<$Res>
    implements $CardInfoCopyWith<$Res> {
  factory _$$CardInfoImplCopyWith(
          _$CardInfoImpl value, $Res Function(_$CardInfoImpl) then) =
      __$$CardInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'card_number') String? cardNumber,
      @JsonKey(name: 'card_holder') String? cardHolderName,
      @JsonKey(name: 'expiration_date') String? expirationDate});
}

/// @nodoc
class __$$CardInfoImplCopyWithImpl<$Res>
    extends _$CardInfoCopyWithImpl<$Res, _$CardInfoImpl>
    implements _$$CardInfoImplCopyWith<$Res> {
  __$$CardInfoImplCopyWithImpl(
      _$CardInfoImpl _value, $Res Function(_$CardInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardNumber = freezed,
    Object? cardHolderName = freezed,
    Object? expirationDate = freezed,
  }) {
    return _then(_$CardInfoImpl(
      cardNumber: freezed == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      cardHolderName: freezed == cardHolderName
          ? _value.cardHolderName
          : cardHolderName // ignore: cast_nullable_to_non_nullable
              as String?,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CardInfoImpl implements _CardInfo {
  const _$CardInfoImpl(
      {@JsonKey(name: 'card_number') this.cardNumber,
      @JsonKey(name: 'card_holder') this.cardHolderName,
      @JsonKey(name: 'expiration_date') this.expirationDate});

  factory _$CardInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CardInfoImplFromJson(json);

  @override
  @JsonKey(name: 'card_number')
  final String? cardNumber;
  @override
  @JsonKey(name: 'card_holder')
  final String? cardHolderName;
  @override
  @JsonKey(name: 'expiration_date')
  final String? expirationDate;

  @override
  String toString() {
    return 'CardInfo(cardNumber: $cardNumber, cardHolderName: $cardHolderName, expirationDate: $expirationDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardInfoImpl &&
            (identical(other.cardNumber, cardNumber) ||
                other.cardNumber == cardNumber) &&
            (identical(other.cardHolderName, cardHolderName) ||
                other.cardHolderName == cardHolderName) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cardNumber, cardHolderName, expirationDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CardInfoImplCopyWith<_$CardInfoImpl> get copyWith =>
      __$$CardInfoImplCopyWithImpl<_$CardInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CardInfoImplToJson(
      this,
    );
  }
}

abstract class _CardInfo implements CardInfo {
  const factory _CardInfo(
          {@JsonKey(name: 'card_number') final String? cardNumber,
          @JsonKey(name: 'card_holder') final String? cardHolderName,
          @JsonKey(name: 'expiration_date') final String? expirationDate}) =
      _$CardInfoImpl;

  factory _CardInfo.fromJson(Map<String, dynamic> json) =
      _$CardInfoImpl.fromJson;

  @override
  @JsonKey(name: 'card_number')
  String? get cardNumber;
  @override
  @JsonKey(name: 'card_holder')
  String? get cardHolderName;
  @override
  @JsonKey(name: 'expiration_date')
  String? get expirationDate;
  @override
  @JsonKey(ignore: true)
  _$$CardInfoImplCopyWith<_$CardInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
