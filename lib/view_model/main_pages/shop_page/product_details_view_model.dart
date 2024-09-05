import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:zeydal_ecom/data/local_storage/storage.dart';
import '../../../data/model/product.dart';
import '../../../data/repository/product_repository.dart';

class ProductDetailsViewModel with ChangeNotifier {
  final _storage = Storage();
  final List<Product> _products = [];
  final _repo = ProductRepository();

  List<Product> get products => _products;

  ProductDetailsViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getProducts();
    });
  }

  Future<void> addProductToCart(String productId) async {
    final url = Uri.parse(ApiConstants.createCart);
    final String token = await _storage.readSecureData('user_token');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token, // Eğer token gerekiyorsa
        },
        body: json.encode({
          'productId': productId,
        }),
      );

      if (response.statusCode == 200) {
        // Başarılı bir yanıt aldığımızda yapılacak işlemler
        final responseData = json.decode(response.body);
        print('Ürün sepete eklendi: ${responseData['message']}');
        // Sepet verilerini güncelle veya kullanıcıyı bilgilendir
      } else {
        // Başarısız yanıt durumları
        final responseData = json.decode(response.body);
        throw Exception(responseData['error'] ?? 'Sepet oluşturulamadı.');
      }
    } catch (error) {
      print('Sepete ürün ekleme hatası: $error');
      throw error; // Hata mesajını üst katmanlara ilet
    }
  }

  void _getProducts() async {
    final products = await _repo.getRandomProducts("");
    _products.clear();
    _products.addAll(products);
    notifyListeners();
  }
}
