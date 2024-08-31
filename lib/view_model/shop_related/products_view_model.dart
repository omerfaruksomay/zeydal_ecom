import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zeydal_ecom/data/model/product.dart';

class ProductsViewModel with ChangeNotifier {
  final String? category;
  final List<Product> _products = [];

  List<Product> get products => _products;

  ProductsViewModel(this.category) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getProducts();
    });
  }

  void _getProducts() async {
    Uri apiUri;

    if (category != null && category!.isNotEmpty) {
      apiUri = Uri.parse(
          'https://10.0.2.2:3000/api/get-products-by-category?category=$category');
    } else {
      // Kategori tanımlı değilse, tüm ürünleri getir
      apiUri = Uri.parse('https://10.0.2.2:3000/api/get-all-products');
    }

    http.Response response = await http.get(apiUri);
    if (response.statusCode == 200) {
      List<dynamic> apiResponse = jsonDecode(response.body);
      _products.clear();
      _products.addAll(apiResponse
          .map((productJson) => Product.fromJson(productJson))
          .toList());
      notifyListeners();
    } else {
      // Hata durumunu ele al
      print(response.body);
    }
  }
}