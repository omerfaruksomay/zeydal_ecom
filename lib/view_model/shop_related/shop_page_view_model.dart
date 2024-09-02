import 'package:flutter/material.dart';
import 'package:zeydal_ecom/data/repository/category_repository.dart';

import '../../data/model/category.dart';

class ShopPageViewModel with ChangeNotifier {
  final _repo = CategoryRepository();
  final List<Category> _categories = [];

  List<Category> get categories => _categories;

  ShopPageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getAllCategories();
    });
  }

  void _getAllCategories() async {
    final categories = await _repo.getCategories();
    _categories.clear();
    _categories.addAll(categories);
    notifyListeners();
  }
}
