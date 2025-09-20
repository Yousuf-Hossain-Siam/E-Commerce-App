import '../../model/product_model.dart';
import '../../model/cart_item.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({bool forceRefresh = false});
  Future<List<Product>> searchProducts(String query);
  Future<void> toggleFavorite(String productId);
  Future<List<Product>> getFavoriteProducts();
  Future<void> addToCart(Product product, {int quantity = 1});
  Future<void> removeFromCart(String productId);
  Future<void> updateCartItemQuantity(String productId, int quantity);
  Future<List<CartItem>> getCartItems();
  Future<double> getCartTotal();
  Future<void> clearCart();
}
