import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:zeydal_ecom/data/local_storage/storage.dart';
import 'package:zeydal_ecom/data/model/comment.dart';
import 'package:zeydal_ecom/view/main_pages/shop_page/comments/all_comments_page.dart';
import 'package:zeydal_ecom/view/main_pages/shop_page/comments/create_comment_page.dart';
import 'package:zeydal_ecom/view_model/main_pages/shop_page/comments/all_comments_page_view_model.dart';
import 'package:zeydal_ecom/view_model/main_pages/shop_page/comments/create_comment_page_view_model.dart';

import '../../../data/model/product.dart';
import '../../../data/repository/product_repository.dart';
import '../../../view/widgets/custom_snacbar.dart';

class ProductDetailsViewModel with ChangeNotifier {
  final _storage = Storage();
  final List<Product> _products = [];
  final _repo = ProductRepository();
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  List<Product> get products => _products;

  ProductDetailsViewModel(String productId) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getProducts();
      _getComments(productId);
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

  Future<void> _getComments(String productId) async {
    final url =
        Uri.parse("${ApiConstants.getCommentsByProduct}?productId=$productId");
    final String token = await _storage.readSecureData('user_token');
    try {
      final response = await http.get(url, headers: {
        'Authorization': token, // Gerekliyse header ekleyin
      });
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        List<Comment> loadedComments = [];
        for (var commentJson in responseData) {
          loadedComments.add(Comment.fromJson(commentJson));
        }
        _comments = loadedComments;
        notifyListeners();
      } else {
        throw Exception('Failed to load cards');
      }
    } catch (err) {
      throw Exception('Error fetching cards: $err');
    }
  }

  void goAllCommentsPage(BuildContext context, String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => AllCommentsPageViewModel(productId),
          child: AllCommentsPage(
            productId: productId,
          ),
        ),
      ),
    );
  }

  void goCreateCommentsPage(BuildContext context, String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => CreateCommentPageViewModel(),
          child: CreateCommentPage(
            productId: productId,
          ),
        ),
      ),
    );
  }
}
