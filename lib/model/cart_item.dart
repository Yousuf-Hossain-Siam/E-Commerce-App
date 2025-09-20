import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'product_model.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
@HiveType(typeId: 1)
class CartItem with _$CartItem {
  const factory CartItem({
    @HiveField(0) required Product product,
    @HiveField(1) @Default(1) int quantity,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

extension CartItemExtension on CartItem {
  double get totalPrice => product.price * quantity;
}
