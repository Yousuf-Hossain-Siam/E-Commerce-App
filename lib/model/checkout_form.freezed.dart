// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CheckoutForm _$CheckoutFormFromJson(Map<String, dynamic> json) {
  return _CheckoutForm.fromJson(json);
}

/// @nodoc
mixin _$CheckoutForm {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckoutFormCopyWith<CheckoutForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutFormCopyWith<$Res> {
  factory $CheckoutFormCopyWith(
          CheckoutForm value, $Res Function(CheckoutForm) then) =
      _$CheckoutFormCopyWithImpl<$Res, CheckoutForm>;
  @useResult
  $Res call({String name, String email, String address, String? phone});
}

/// @nodoc
class _$CheckoutFormCopyWithImpl<$Res, $Val extends CheckoutForm>
    implements $CheckoutFormCopyWith<$Res> {
  _$CheckoutFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? address = null,
    Object? phone = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckoutFormImplCopyWith<$Res>
    implements $CheckoutFormCopyWith<$Res> {
  factory _$$CheckoutFormImplCopyWith(
          _$CheckoutFormImpl value, $Res Function(_$CheckoutFormImpl) then) =
      __$$CheckoutFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String email, String address, String? phone});
}

/// @nodoc
class __$$CheckoutFormImplCopyWithImpl<$Res>
    extends _$CheckoutFormCopyWithImpl<$Res, _$CheckoutFormImpl>
    implements _$$CheckoutFormImplCopyWith<$Res> {
  __$$CheckoutFormImplCopyWithImpl(
      _$CheckoutFormImpl _value, $Res Function(_$CheckoutFormImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? address = null,
    Object? phone = freezed,
  }) {
    return _then(_$CheckoutFormImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CheckoutFormImpl implements _CheckoutForm {
  const _$CheckoutFormImpl(
      {required this.name,
      required this.email,
      required this.address,
      this.phone});

  factory _$CheckoutFormImpl.fromJson(Map<String, dynamic> json) =>
      _$$CheckoutFormImplFromJson(json);

  @override
  final String name;
  @override
  final String email;
  @override
  final String address;
  @override
  final String? phone;

  @override
  String toString() {
    return 'CheckoutForm(name: $name, email: $email, address: $address, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutFormImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, address, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutFormImplCopyWith<_$CheckoutFormImpl> get copyWith =>
      __$$CheckoutFormImplCopyWithImpl<_$CheckoutFormImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CheckoutFormImplToJson(
      this,
    );
  }
}

abstract class _CheckoutForm implements CheckoutForm {
  const factory _CheckoutForm(
      {required final String name,
      required final String email,
      required final String address,
      final String? phone}) = _$CheckoutFormImpl;

  factory _CheckoutForm.fromJson(Map<String, dynamic> json) =
      _$CheckoutFormImpl.fromJson;

  @override
  String get name;
  @override
  String get email;
  @override
  String get address;
  @override
  String? get phone;
  @override
  @JsonKey(ignore: true)
  _$$CheckoutFormImplCopyWith<_$CheckoutFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
