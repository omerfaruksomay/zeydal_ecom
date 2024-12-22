import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/model/comment.dart';
import 'package:zeydal_ecom/view/main_pages/shop_page/comments/create_comment_page.dart';
import 'package:zeydal_ecom/view_model/main_pages/shop_page/comments/create_comment_page_view_model.dart';

class AllCommentsPageViewModel with ChangeNotifier {
  final List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  AllCommentsPageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getComments();
    });
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

  void goAddCommentPage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ChangeNotifierProvider(
        create: (context) => CreateCommentPageViewModel(),
        child: CreateCommentPage(),
      ),
    );
  }
}
