import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/product_model.dart';
import '../model/cart_item.dart';
import 'repository_providers.dart';

// Search query notifier
class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }

  void clearQuery() {
    state = '';
  }
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(() {
  return SearchQueryNotifier();
});

// Product-related providers
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.read(productRepositoryProvider);
  return repository.getProducts();
});

final filteredProductsProvider = FutureProvider<List<Product>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final repository = ref.read(productRepositoryProvider);
  return repository.searchProducts(query);
});

final favoriteProductsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.read(productRepositoryProvider);
  return repository.getFavoriteProducts();
});

// Cart-related providers
final cartItemsProvider = FutureProvider<List<CartItem>>((ref) async {
  final repository = ref.read(productRepositoryProvider);
  return repository.getCartItems();
});

final cartTotalProvider = FutureProvider<double>((ref) async {
  final repository = ref.read(productRepositoryProvider);
  return repository.getCartTotal();
});

final cartItemCountProvider = FutureProvider<int>((ref) async {
  final items = await ref.watch(cartItemsProvider.future);
  return items.fold<int>(0, (sum, item) => sum + item.quantity);
});

// Actions
class ProductActions {
  static Future<void> toggleFavorite(WidgetRef ref, String productId) async {
    final repository = ref.read(productRepositoryProvider);
    await repository.toggleFavorite(productId);

    // Refresh related providers
    ref.invalidate(productsProvider);
    ref.invalidate(favoriteProductsProvider);
    ref.invalidate(filteredProductsProvider);
  }

  static Future<void> addToCart(
    WidgetRef ref,
    Product product, {
    int quantity = 1,
  }) async {
    final repository = ref.read(productRepositoryProvider);
    await repository.addToCart(product, quantity: quantity);

    // Refresh cart providers
    ref.invalidate(cartItemsProvider);
    ref.invalidate(cartTotalProvider);
    ref.invalidate(cartItemCountProvider);
  }

  static Future<void> removeFromCart(WidgetRef ref, String productId) async {
    final repository = ref.read(productRepositoryProvider);
    await repository.removeFromCart(productId);

    // Refresh cart providers
    ref.invalidate(cartItemsProvider);
    ref.invalidate(cartTotalProvider);
    ref.invalidate(cartItemCountProvider);
  }

  static Future<void> updateCartQuantity(
    WidgetRef ref,
    String productId,
    int quantity,
  ) async {
    final repository = ref.read(productRepositoryProvider);
    await repository.updateCartItemQuantity(productId, quantity);

    // Refresh cart providers
    ref.invalidate(cartItemsProvider);
    ref.invalidate(cartTotalProvider);
    ref.invalidate(cartItemCountProvider);
  }

  static Future<void> clearCart(WidgetRef ref) async {
    final repository = ref.read(productRepositoryProvider);
    await repository.clearCart();

    // Refresh cart providers
    ref.invalidate(cartItemsProvider);
    ref.invalidate(cartTotalProvider);
    ref.invalidate(cartItemCountProvider);
  }

  static Future<void> refreshProducts(WidgetRef ref) async {
    final repository = ref.read(productRepositoryProvider);
    await repository.getProducts(forceRefresh: true);

    // Refresh all product providers
    ref.invalidate(productsProvider);
    ref.invalidate(filteredProductsProvider);
    ref.invalidate(favoriteProductsProvider);
  }
}
