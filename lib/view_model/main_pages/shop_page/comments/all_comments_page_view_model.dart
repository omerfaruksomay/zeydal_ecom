import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/model/comment.dart';
import 'package:zeydal_ecom/view/main_pages/shop_page/comments/create_comment_page.dart';
import 'package:zeydal_ecom/view_model/main_pages/shop_page/comments/create_comment_page_view_model.dart';

import '../../../../data/api_constants/api_constants.dart';
import '../../../../data/local_storage/storage.dart';

class AllCommentsPageViewModel with ChangeNotifier {
  final _storage = Storage();
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  AllCommentsPageViewModel(String productId) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getComments(productId);
    });
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

  void goAddCommentPage(BuildContext context, String productId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ChangeNotifierProvider(
        create: (context) => CreateCommentPageViewModel(),
        child: CreateCommentPage(
          productId: productId,
        ),
      ),
    );
  }
}
