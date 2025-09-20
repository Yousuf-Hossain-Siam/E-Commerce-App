import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/product_datasource.dart';
import '../data/datasources/local_datasource.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';

// Data source providers
final productDataSourceProvider = Provider<ProductDataSource>((ref) {
  return ApiProductDataSource();
});

final localDataSourceProvider = Provider<LocalDataSource>((ref) {
  return HiveLocalDataSource();
});

// Repository provider
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    productDataSource: ref.read(productDataSourceProvider),
    localDataSource: ref.read(localDataSourceProvider),
  );
});
