import 'package:go_router/go_router.dart';
import '../views/product_list_page.dart';
import '../views/product_detail_page.dart';
import '../views/cart_page.dart';
import '../views/checkout_page.dart';
import '../views/success_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const ProductListPage(),
      ),
      GoRoute(
        path: '/product/:id',
        name: 'productDetail',
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return ProductDetailPage(productId: productId);
        },
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => const CheckoutPage(),
      ),
      GoRoute(
        path: '/success',
        name: 'success',
        builder: (context, state) => const SuccessPage(),
      ),
    ],
    // Optional: Add error handling
    errorBuilder: (context, state) => const ProductListPage(),
    // Optional: Add initial location
    initialLocation: '/',
  );
}
