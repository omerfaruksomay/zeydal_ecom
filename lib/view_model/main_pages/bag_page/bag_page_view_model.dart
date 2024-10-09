import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:zeydal_ecom/data/local_storage/storage.dart';
import 'package:zeydal_ecom/view/main_pages/bag_page/checkout_page.dart';
import 'package:zeydal_ecom/view_model/main_pages/bag_page/checkout_page_view_model.dart';

import '../../../data/model/cart.dart';
import '../../../view/widgets/custom_snacbar.dart';

class BagPageViewModel with ChangeNotifier {
  final _storage = Storage();
  bool _isLoading = true;

  bool get isLoading => _isLoading;

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
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _cart = Cart.fromJson(responseData);
        notifyListeners();
        print('Sepet getirildi: $_cart');
      } else {
        final responseData = json.decode(response.body);
        throw Exception(responseData['error'] ?? 'Sepet getirilemedi.');
      }
    } catch (error) {
      print('Sepet getirme hatası: $error');
      throw error; // Hata mesajını üst katmanlara ilet
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      _isLoading = false;
      notifyListeners();
    }
  }

  double getTotalPrice() {
    if (_cart == null || _cart!.products.isEmpty) {
      return 0.0;
    }
    double total = 0.0;
    for (var product in _cart!.products) {
      total += product['productId']['price'] * product['quantity'];
    }
    return total;
  }

  Future<void> removeProductFromCart(
      BuildContext context, String cartId, String productId) async {
    final url = Uri.parse('${ApiConstants.deleteProductInCart}/$cartId');
    final String token = await _storage.readSecureData('user_token');
    print(productId);

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
        _fetchCart();
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

  Future<void> addProductToCart(String productId, context) async {
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
        print(responseData);
        _fetchCart();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: CustomSnackbar(
              message: 'Ürün adedi arttırıldı.',
              contentType: ContentType.success,
              title: 'Harika!',
            ),
          ),
        );

        // Sepet verilerini güncelle veya kullanıcıyı bilgilendir
      } else {
        // Başarısız yanıt durumları
        final responseData = json.decode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: CustomSnackbar(
              message: 'Bir hata oluştu.',
              contentType: ContentType.failure,
              title: 'Opps!',
            ),
          ),
        );

        throw Exception(responseData['error'] ?? 'Sepet oluşturulamadı.');
      }
    } catch (error) {
      print('Sepete ürün ekleme hatası: $error');
      throw error; // Hata mesajını üst katmanlara ilet
    }
  }

  void goCheckoutPage(BuildContext context, Cart cart, double totalAmount) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => CheckoutPageViewModel(),
          child: CheckoutPage(
            cart: cart,
            totalAmount: totalAmount,
          ),
        ),
      ),
    ).then((value) {
      _cart = null;
      notifyListeners();
    });
  }
}
