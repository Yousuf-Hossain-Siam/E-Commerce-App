import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/themes.dart';
import '../providers/product_providers.dart';
import '../widgets/product_card.dart';
import '../widgets/shimmer_loading.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final cartItemCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: const Text('E-Commerce', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () => context.go('/cart'),
              icon: cartItemCount.when(
                data: (count) => Badge(
                  label: Text('$count'),
                  child: const Icon(Icons.shopping_cart, color: Colors.white),
                ),
                loading: () =>
                    const Icon(Icons.shopping_cart, color: Colors.white),
                // ignore: unnecessary_underscores
                error: (_, __) =>
                    const Icon(Icons.shopping_cart, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: products.when(
        data: (productList) {
          if (productList.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ProductActions.refreshProducts(ref);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return ProductCard(
                    product: product,
                    onTap: () => context.go('/product/${product.id}'),
                    onFavoriteToggle: () async {
                      await ProductActions.toggleFavorite(ref, product.id);
                    },
                    onAddToCart: () async {
                      await ProductActions.addToCart(ref, product);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart!')),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          );
        },
        loading: () => const ProductListShimmer(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 50),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(productsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
