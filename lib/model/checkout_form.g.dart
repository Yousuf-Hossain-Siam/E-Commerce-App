// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CheckoutFormImpl _$$CheckoutFormImplFromJson(Map<String, dynamic> json) =>
    _$CheckoutFormImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$CheckoutFormImplToJson(_$CheckoutFormImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
    };
