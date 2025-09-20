import '../../domain/repositories/product_repository.dart';
import '../../model/product_model.dart';
import '../../model/cart_item.dart';
import '../datasources/product_datasource.dart';
import '../datasources/local_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource _productDataSource;
  final LocalDataSource _localDataSource;

  List<Product> _cachedProducts = [];
  List<String> _favoriteIds = [];
  List<CartItem> _cartItems = [];

  ProductRepositoryImpl({
    required ProductDataSource productDataSource,
    required LocalDataSource localDataSource,
  }) : _productDataSource = productDataSource,
       _localDataSource = localDataSource;

  Future<void> _loadFromCache() async {
    _cachedProducts = await _localDataSource.getCachedProducts();
    _favoriteIds = await _localDataSource.getFavoriteProductIds();
    _cartItems = await _localDataSource.getCartItems();
  }

  @override
  Future<List<Product>> getProducts({bool forceRefresh = false}) async {
    if (_cachedProducts.isEmpty || forceRefresh) {
      try {
        // Try to fetch from API
        final products = await _productDataSource.getProducts();
        await _localDataSource.cacheProducts(products);
        _cachedProducts = products;

        // Update favorites status
        _cachedProducts = _cachedProducts.map((product) {
          return product.copyWith(
            isFavorite: _favoriteIds.contains(product.id),
          );
        }).toList();
      } catch (e) {
        // Fallback to cached data if API fails
        if (_cachedProducts.isEmpty) {
          await _loadFromCache();
        }
        if (_cachedProducts.isEmpty) {
          rethrow;
        }
      }
    }
    return _cachedProducts;
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final products = await getProducts();
    if (query.isEmpty) return products;

    return products
        .where(
          (product) =>
              product.title.toLowerCase().contains(query.toLowerCase()) ||
              product.category.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  @override
  Future<void> toggleFavorite(String productId) async {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }

    await _localDataSource.saveFavoriteProductIds(_favoriteIds);

    // Update cached products
    _cachedProducts = _cachedProducts.map((product) {
      if (product.id == productId) {
        return product.copyWith(isFavorite: !product.isFavorite);
      }
      return product;
    }).toList();
  }

  @override
  Future<List<Product>> getFavoriteProducts() async {
    final products = await getProducts();
    return products.where((product) => product.isFavorite).toList();
  }

  @override
  Future<void> addToCart(Product product, {int quantity = 1}) async {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + quantity,
      );
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }

    await _localDataSource.saveCartItems(_cartItems);
  }

  @override
  Future<void> removeFromCart(String productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
    await _localDataSource.saveCartItems(_cartItems);
  }

  @override
  Future<void> updateCartItemQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
      await _localDataSource.saveCartItems(_cartItems);
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    if (_cartItems.isEmpty) {
      await _loadFromCache();
    }
    return _cartItems;
  }

  @override
  Future<double> getCartTotal() async {
    final items = await getCartItems();
    double total = 0.0;
    for (final item in items) {
      total += item.totalPrice;
    }
    return total;
  }

  @override
  Future<void> clearCart() async {
    _cartItems.clear();
    await _localDataSource.saveCartItems(_cartItems);
  }
}
