import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/product.dart';

class AllProductsViewModel with ChangeNotifier {
  final productsApiKey =
      Uri.parse('https://10.0.2.2:3000/api/get-all-products');

  final List<Product> _products = [];

  List<Product> get products => _products;

  AllProductsViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getProducts();
    });
  }

  void _getProducts() async {
    http.Response response = await http.get(productsApiKey);
    if (response.statusCode == 200) {
      List<dynamic> apiResponse = jsonDecode(response.body);
      _products.clear();
      _products.addAll(apiResponse
          .map((productJson) => Product.fromJson(productJson))
          .toList());
      notifyListeners();
    } else {
      // Handle error response
      print(response.body);
    }
  }
}
