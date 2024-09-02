import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_constants/api_constants.dart';
import '../model/product.dart';

class ProductDataSource {
  Future<List<Product>> fetchProducts({String? category}) async {
    Uri apiUri;

    if (category != null && category.isNotEmpty) {
      apiUri =
          Uri.parse('${ApiConstants.getProductsByCategory}?category=$category');
    } else {
      // Kategori tanımlı değilse, tüm ürünleri getir
      apiUri = Uri.parse(ApiConstants.getAllProducts);
    }

    http.Response response = await http.get(apiUri);
    if (response.statusCode == 200) {
      List<dynamic> apiResponse = jsonDecode(response.body);
      return apiResponse
          .map((productJson) => Product.fromJson(productJson))
          .toList();
    } else {
      // Hata durumunu ele al
      print(response.body);
      throw Exception('Failed to load products');
    }
  }
}
