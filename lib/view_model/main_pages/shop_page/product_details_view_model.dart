import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:zeydal_ecom/data/local_storage/storage.dart';
import 'package:zeydal_ecom/data/model/comment.dart';

import '../../../data/model/product.dart';
import '../../../data/repository/product_repository.dart';
import '../../../view/widgets/custom_snacbar.dart';

class ProductDetailsViewModel with ChangeNotifier {
  final _storage = Storage();
  final List<Product> _products = [];
  final _repo = ProductRepository();
  final List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  List<Product> get products => _products;

  ProductDetailsViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getProducts();
      _getComments();
    });
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
        print('Ürün sepete eklendi: ${responseData['message']}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: CustomSnackbar(
              message: 'Ürün sepete eklendi.',
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
              message: 'Ürün sepete eklenirken bir hata oluştu.',
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

  void _getProducts() async {
    final products = await _repo.getRandomProducts("");
    _products.clear();
    _products.addAll(products);
    notifyListeners();
  }

  void _getComments() {
    Comment cm1 = Comment(
      id: "1",
      productId: "1",
      rating: 2,
      comment: "Deneme",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    Comment cm2 = Comment(
      id: "1",
      productId: "1",
      rating: 2,
      comment: "Deneme 123 ",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    Comment cm3 = Comment(
      id: "1",
      productId: "1",
      rating: 4,
      comment: "Deneme 3123 12",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    Comment cm4 = Comment(
      id: "1",
      productId: "1",
      rating: 1,
      comment: "Deneme 1312 3123 1",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    Comment cm5 = Comment(
      id: "1",
      productId: "1",
      rating: 5,
      comment: "Deneme",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _comments.clear();
    _comments.add(cm1);
    _comments.add(cm2);
    _comments.add(cm3);
    _comments.add(cm4);
    _comments.add(cm5);
    notifyListeners();
  }
}
