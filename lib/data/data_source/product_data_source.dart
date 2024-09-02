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


  Future<List<Product>> fetchRandomProducts({String? category}) async {
    try {
      // Mevcut fetchProducts metodunu kullanarak tüm ürünleri al
      List<Product> allProducts = await fetchProducts(category: category);

      // Rastgele 5 ürün seçmek için
      if (allProducts.length <= 5) {
        // Eğer toplam ürün sayısı 5 veya daha az ise tümünü döndür
        return allProducts;
      } else {
        // Eğer 5'ten fazla ürün varsa, rastgele 5 tanesini seç
        allProducts.shuffle();
        return allProducts.take(5).toList();
      }
    } catch (e) {
      print('Failed to fetch random products: $e');
      throw Exception('Failed to fetch random products');
    }
  }


}
