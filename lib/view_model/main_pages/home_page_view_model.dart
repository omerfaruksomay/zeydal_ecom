import 'package:flutter/material.dart';
import 'package:zeydal_ecom/data/repository/product_repository.dart';

import '../../data/model/product.dart';

class HomePageViewModel with ChangeNotifier {
  final List<Product> _products = [];
  final _repo = ProductRepository();

  List<Product> get products => _products;

  HomePageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getProducts();
    });
  }

  void _getProducts() async {
    final products = await _repo.getRandomProducts("");
    _products.clear();
    _products.addAll(products);
    notifyListeners();
  }
}
