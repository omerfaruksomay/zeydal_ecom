import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zeydal_ecom/view/main_pages/profile_page/order_details_page.dart';
import 'dart:convert';

import '../../../data/api_constants/api_constants.dart';
import '../../../data/local_storage/storage.dart';
import '../../../data/model/cart.dart'; // Token veya kullanıcı verilerini sakladığınız bir local storage sınıfı

class MyOrdersPageViewModel with ChangeNotifier {
  final _storage = Storage();
  List<Cart> carts = [];

  MyOrdersPageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserOrders();
    });
  }

  Future<void> _getUserOrders() async {
    final url = Uri.parse(ApiConstants.getUserOrders); // API URL
    final String token = await _storage
        .readSecureData('user_token'); // Token'ı secure storage'dan al
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
          // Token'ı Authorization header'a ekle
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse =
            json.decode(response.body); // JSON cevabını parse et
        carts = jsonResponse
            .map((order) => Cart.fromJson(order))
            .toList(); // Cart modeline dönüştür
        notifyListeners(); // UI güncellemesi için notifyListeners çağır
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (error) {
      print('Sipariş getirme hatası: $error');
      rethrow;
    }
  }

  double getTotalPrice(Cart cart) {
    double total = 0.0;
    for (var product in cart.products) {
      total += product['productId']['price'] * product['quantity'];
    }
    return total;
  }

  void goOrderDetails(BuildContext context, Cart cart, double totalPrice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailsPage(
          cart: cart,
          totalPrice: totalPrice,
        ),
      ),
    );
  }
}
