import 'package:hive/hive.dart';
import '../../model/product_model.dart';
import '../../model/cart_item.dart';

abstract class LocalDataSource {
  Future<List<Product>> getCachedProducts();
  Future<void> cacheProducts(List<Product> products);
  Future<List<CartItem>> getCartItems();
  Future<void> saveCartItems(List<CartItem> items);
  Future<List<String>> getFavoriteProductIds();
  Future<void> saveFavoriteProductIds(List<String> ids);
  Future<void> clearCache();
}

class HiveLocalDataSource implements LocalDataSource {
  static const String _productsBoxName = 'products';
  static const String _cartBoxName = 'cart';
  static const String _favoritesBoxName = 'favorites';

  Box<Product>? _productsBox;
  Box<CartItem>? _cartBox;
  Box<List<String>>? _favoritesBox;

  Future<void> init() async {
    _productsBox = await Hive.openBox<Product>(_productsBoxName);
    _cartBox = await Hive.openBox<CartItem>(_cartBoxName);
    _favoritesBox = await Hive.openBox<List<String>>(_favoritesBoxName);
  }

  @override
  Future<List<Product>> getCachedProducts() async {
    final box = _productsBox ?? await Hive.openBox<Product>(_productsBoxName);
    return box.values.toList();
  }

  @override
  Future<void> cacheProducts(List<Product> products) async {
    final box = _productsBox ?? await Hive.openBox<Product>(_productsBoxName);
    await box.clear();
    for (int i = 0; i < products.length; i++) {
      await box.put(i, products[i]);
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    final box = _cartBox ?? await Hive.openBox<CartItem>(_cartBoxName);
    return box.values.toList();
  }

  @override
  Future<void> saveCartItems(List<CartItem> items) async {
    final box = _cartBox ?? await Hive.openBox<CartItem>(_cartBoxName);
    await box.clear();
    for (int i = 0; i < items.length; i++) {
      await box.put(i, items[i]);
    }
  }

  @override
  Future<List<String>> getFavoriteProductIds() async {
    final box =
        _favoritesBox ?? await Hive.openBox<List<String>>(_favoritesBoxName);
    return box.get('favorites', defaultValue: <String>[]) ?? <String>[];
  }

  @override
  Future<void> saveFavoriteProductIds(List<String> ids) async {
    final box =
        _favoritesBox ?? await Hive.openBox<List<String>>(_favoritesBoxName);
    await box.put('favorites', ids);
  }

  @override
  Future<void> clearCache() async {
    await _productsBox?.clear();
    await _cartBox?.clear();
    await _favoritesBox?.clear();
  }
}
