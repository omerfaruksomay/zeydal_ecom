import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:zeydal_ecom/data/local_storage/storage.dart';

import '../../data/model/cart.dart';
import '../../view/widgets/custom_snacbar.dart';

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

  Future<void> removeProductFromCart(context,String cartId, String productId) async {
    final url = Uri.parse('${ApiConstants.deleteProductInCart}/$cartId');
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
        // Başarılı bir yanıt aldığımızda ürünü sepetten çıkar ve UI'ı güncelle
        _cart!.products.removeWhere((product) => product.id == productId);
        notifyListeners(); // UI'ı güncellemek için
        print('Ürün sepetten çıkarıldı: $productId');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: CustomSnackbar(
              message: '',
              contentType: ContentType.warning,
              title: 'Ürün sepetten çıkartıldı.',
            ),
          ),
        );
      } else {
        // Başarısız yanıt durumları
        final responseData = json.decode(response.body);
        throw Exception(responseData['error'] ?? 'Ürün sepetten çıkarılamadı.');
      }
    } catch (error) {
      print('Ürün çıkarma hatası: $error');
      throw error; // Hata mesajını üst katmanlara ilet
    }
  }


}
