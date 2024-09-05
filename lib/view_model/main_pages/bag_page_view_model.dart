import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:zeydal_ecom/data/local_storage/storage.dart';

import '../../data/model/cart.dart';

class BagPageViewModel with ChangeNotifier {
  final _storage = Storage();

  Cart? _cart; // Sepet verilerini tutmak için Cart modelini kullanıyoruz
  Cart? get cart => _cart;

  BagPageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchCart();
    });
  }

  Future<void> _fetchCart() async {
    final url = Uri.parse(ApiConstants.getCart);
    final String token = await _storage.readSecureData('user_token');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token, // Eğer token gerekiyorsa
        },
      );

      if (response.statusCode == 200) {
        // Başarılı bir yanıt aldığımızda sepet verilerini güncelle
        final responseData = json.decode(response.body);
        _cart = Cart.fromJson(responseData);
        notifyListeners(); // UI'ı güncellemek için
        print('Sepet getirildi: $_cart');
      } else {
        // Başarısız yanıt durumları
        final responseData = json.decode(response.body);
        throw Exception(responseData['error'] ?? 'Sepet getirilemedi.');
      }
    } catch (error) {
      print('Sepet getirme hatası: $error');
      throw error; // Hata mesajını üst katmanlara ilet
    }
  }

  double getTotalPrice() {
    if (_cart == null || _cart!.products.isEmpty) {
      return 0.0;
    }
    double total = 0.0;
    for (var product in _cart!.products) {
      total += product.price;
    }
    return total;
  }

}
