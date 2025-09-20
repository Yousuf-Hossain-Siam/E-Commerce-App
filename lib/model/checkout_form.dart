import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_form.freezed.dart';
part 'checkout_form.g.dart';

@freezed
class CheckoutForm with _$CheckoutForm {
  const factory CheckoutForm({
    required String name,
    required String email,
    required String address,
    String? phone,
  }) = _CheckoutForm;

  factory CheckoutForm.fromJson(Map<String, dynamic> json) =>
      _$CheckoutFormFromJson(json);
}
