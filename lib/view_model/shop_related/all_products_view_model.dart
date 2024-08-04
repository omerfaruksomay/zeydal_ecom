import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/product.dart';

class AllProductsViewModel with ChangeNotifier {
  final productsApiKey =
      Uri.parse('https://10.0.2.2:3000/api/get-all-products');
  final String bearerToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1dWlkIjoiMGY1YTVkZTgtMWNjYS00MjhmLWJkOGYtZGFmNzA4OWIwNTY1IiwibG9jYWxlIjoidHIiLCJpZGVudGl0eU51bWJlciI6IjAwMDAwMDAwMDAwIiwiYXZhdGFyQ29sb3IiOiJkNWY0MGMiLCJjb3VudHJ5IjoiVHVya2V5IiwiX2lkIjoiNjY5OTFlOTZmNTQ2YWJiZDZlNTkxN2NhIiwicm9sZSI6ImFkbWluIiwibmFtZSI6ImFobWVkIiwic3VybmFtZSI6ImtheWEiLCJlbWFpbCI6ImFkbWluQGdtYWlsLmNvbSIsInBob25lTnVtYmVyIjoiKzkwNTM0OTQ2NjAwMCIsImlzVmVyaWZpZWQiOnRydWUsImNyZWF0ZWRBdCI6IjIwMjQtMDctMThUMTM6NTQ6MzAuNjAyWiIsInVwZGF0ZWRBdCI6IjIwMjQtMDctMThUMTM6NTU6MDUuNDIwWiIsImlhdCI6MTcyMTY3NDI0Nn0.0uWHpi5sy1sYmWWxI5zs1HSatXMGVorHrZw2EbQ7Ocw';

  final List<Product> _products = [];

  List<Product> get products => _products;

  AllProductsViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getProducts();
    });
  }

  void _getProducts() async {
    try {
      http.Response response = await http.get(
        productsApiKey,
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );

      if (response.statusCode == 201) {
        List<dynamic> apiResponse = jsonDecode(response.body);
        _products.clear();
        _products.addAll(apiResponse
            .map((productJson) => Product.fromJson(productJson))
            .toList());
        notifyListeners();
      } else {
        // Handle error response
        print('Failed to load products');
      }
    } catch (e) {
      // Handle network or parsing error
      print('Error: $e');
    }
  }
}
