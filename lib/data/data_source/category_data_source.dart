import 'dart:convert';
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:http/http.dart' as http;

import '../model/category.dart';

class CategoryDataSource {
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(ApiConstants.getCategories));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      List<String> categoryNames = jsonMap.keys.toList();
      List<Category> categories =
          categoryNames.map((name) => Category(name: name)).toList();
      return categories;
    } else {
      print('Failed to load categories: ${response.reasonPhrase}');
      throw Exception('Failed to load categories');
    }
  }
}
