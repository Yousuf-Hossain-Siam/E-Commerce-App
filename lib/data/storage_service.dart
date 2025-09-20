import 'package:hive_flutter/hive_flutter.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/model/cart_item.dart';

class StorageService {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProductAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CartItemAdapter());
    }
  }
}
