import 'package:flutter/material.dart';
import 'package:zeydal_ecom/data/model/product.dart';

import '../../../data/repository/product_repository.dart';

class ProductsViewModel with ChangeNotifier {
  bool _isLoading = false;
  final String? category;
  final List<Product> _products = [];
  final _repo = ProductRepository();

  List<Product> get products => _products;

  bool get isLoading => _isLoading;

  ProductsViewModel(this.category) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getProducts();
    });
  }

  void _getProducts() async {
    _isLoading = true; // Yüklenme başlıyor
    notifyListeners();

    // Gecikme ekleyerek yükleme süresini uzatma
    await Future.delayed(const Duration(seconds: 1));

    final products = await _repo.getProducts(category: category);
    _products.clear();
    _products.addAll(products);

    _isLoading = false; // Yüklenme tamamlandı
    notifyListeners();
  }
}
