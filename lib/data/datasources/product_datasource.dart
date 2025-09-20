import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/product_model.dart';

abstract class ProductDataSource {
  Future<List<Product>> getProducts();
}

class ApiProductDataSource implements ProductDataSource {
  static const String _baseUrl = 'https://fakestoreapi.com/products';
  final http.Client _client;

  ApiProductDataSource({http.Client? client})
    : _client = client ?? http.Client();

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await _client.get(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map((json) => Product.fromJson(_mapApiResponse(json)))
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Map<String, dynamic> _mapApiResponse(Map<String, dynamic> apiJson) {
    return {
      'id': apiJson['id'].toString(),
      'title': apiJson['title'] ?? '',
      'price': (apiJson['price'] ?? 0).toDouble(),
      'description': apiJson['description'] ?? '',
      'category': apiJson['category'] ?? '',
      'image': apiJson['image'] ?? '',
      'rating': apiJson['rating']?['rate']?.toDouble() ?? 4.0,
      'reviewCount': apiJson['rating']?['count'] ?? 0,
      'isFavorite': false,
    };
  }

  void dispose() {
    _client.close();
  }
}
