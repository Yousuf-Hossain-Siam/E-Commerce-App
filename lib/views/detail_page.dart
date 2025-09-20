import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../constants/themes.dart';
import '../providers/product_providers.dart';
import '../widgets/shimmer_loading.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final cartItems = ref.watch(cartItemsProvider);
    final favoriteProducts = ref.watch(favoriteProductsProvider);

    return products.when(
      data: (productList) {
        final product = productList.firstWhere(
          (p) => p.id == productId,
          orElse: () => productList.first,
        );

        return cartItems.when(
          data: (cartItemList) {
            final cartItem = cartItemList
                .where((item) => item.product.id == productId)
                .firstOrNull;
            final quantity = cartItem?.quantity ?? 0;

            return favoriteProducts.when(
              data: (favoriteList) {
                final isFavorite = favoriteList.any(
                  (fav) => fav.id == productId,
                );

                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: kSecondaryColor,
                    title: const Text('Product Details'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          onPressed: () => context.go('/cart'),
                          icon: Consumer(
                            builder: (context, ref, child) {
                              final count = ref.watch(cartItemCountProvider);
                              return count.when(
                                data: (itemCount) => Badge(
                                  label: Text('$itemCount'),
                                  child: const Icon(Icons.shopping_cart),
                                ),
                                loading: () => const Icon(Icons.shopping_cart),
                                // ignore: unnecessary_underscores
                                error: (_, __) =>
                                    const Icon(Icons.shopping_cart),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          color: kLightBackground,
                          child: Image.network(
                            product.image,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.error, size: 50),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: AppTheme.kBigTitle.copyWith(
                                  color: kPrimaryColor,
                                ),
                              ),
                              const Gap(12),
                              Row(
                                children: [
                                  RatingBar(
                                    itemSize: 20,
                                    initialRating: product.rating,
                                    minRating: 1,
                                    maxRating: 5,
                                    allowHalfRating: true,
                                    ignoreGestures: true,
                                    ratingWidget: RatingWidget(
                                      empty: const Icon(
                                        Icons.star_border,
                                        color: Colors.amber,
                                      ),
                                      full: const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      half: const Icon(
                                        Icons.star_half_sharp,
                                        color: Colors.amber,
                                      ),
                                    ),
                                    onRatingUpdate: (value) {},
                                  ),
                                  const Gap(12),
                                  Text('${product.reviewCount} reviews'),
                                ],
                              ),
                              const Gap(8),
                              Text(
                                product.description,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Gap(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${(product.price * (quantity > 0 ? quantity : 1)).toStringAsFixed(2)}',
                                    style: AppTheme.kHeadingOne,
                                  ),
                                  if (quantity > 0) ...[
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await ProductActions.removeFromCart(
                                              ref,
                                              product.id,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                            size: 30,
                                          ),
                                        ),
                                        Text(
                                          quantity.toString(),
                                          style: AppTheme.kCardTitle.copyWith(
                                            fontSize: 24,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await ProductActions.addToCart(
                                              ref,
                                              product,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                              const Gap(20),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kPrimaryColor,
                                        minimumSize: const Size(
                                          double.infinity,
                                          50,
                                        ),
                                      ),
                                      onPressed: () async {
                                        await ProductActions.addToCart(
                                          ref,
                                          product,
                                        );
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Added to cart!'),
                                            ),
                                          );
                                        }
                                      },
                                      child: Text(
                                        quantity > 0
                                            ? 'Add More'
                                            : 'Add to Cart',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(10),
                                  IconButton(
                                    onPressed: () async {
                                      await ProductActions.toggleFavorite(
                                        ref,
                                        product.id,
                                      );
                                    },
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite ? Colors.red : null,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () => Scaffold(
                appBar: AppBar(
                  backgroundColor: kSecondaryColor,
                  title: const Text('Product Details'),
                ),
                body: ShimmerLoading(
                  isLoading: true,
                  child: const ProductDetailShimmer(),
                ),
              ),
              error: (error, stack) => Scaffold(
                body: Center(child: Text('Error loading favorites: $error')),
              ),
            );
          },
          loading: () => Scaffold(
            appBar: AppBar(
              backgroundColor: kSecondaryColor,
              title: const Text('Product Details'),
            ),
            body: ShimmerLoading(
              isLoading: true,
              child: const ProductDetailShimmer(),
            ),
          ),
          error: (error, stack) =>
              Scaffold(body: Center(child: Text('Error loading cart: $error'))),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          title: const Text('Product Details'),
        ),
        body: ShimmerLoading(
          isLoading: true,
          child: const ProductDetailShimmer(),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 50),
              Text('Error: $error'),
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
