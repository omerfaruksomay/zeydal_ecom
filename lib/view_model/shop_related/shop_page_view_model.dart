import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../data/model/category.dart';

class ShopPageViewModel with ChangeNotifier {
  final getAllCategoriesApi =
      Uri.parse('https://10.0.2.2:3000/api/get-categories');
  final List<Category> _categories = [];

  List<Category> get categories => _categories;

  ShopPageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getAllCategories();
    });
  }

  void _getAllCategories() async {
    final response = await http.get(getAllCategoriesApi);
    if (response.statusCode == 200) {

      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      List<String> categoryNames = jsonMap.keys.toList();
      _categories.clear();
      _categories
          .addAll(categoryNames.map((name) => Category(name: name)).toList());
      notifyListeners();
    } else {
      print('Failed to load categories: ${response.reasonPhrase}');
    }
  }
}
