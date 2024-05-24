import 'package:flutter/material.dart';
import 'package:e_commece/models/product_model.dart';
import 'package:e_commece/Services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final products = await ProductService.fetchProducts();
      _products = products;
      notifyListeners();
    } catch (e) {
      print('Failed to fetch products: $e');
    }
  }
}
