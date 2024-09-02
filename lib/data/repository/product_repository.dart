import '../data_source/product_data_source.dart';
import '../model/product.dart';

class ProductRepository {
  final _dataSource = ProductDataSource();

  Future<List<Product>> getProducts({String? category}) {
    return _dataSource.fetchProducts(category: category);
  }

  Future<List<Product>> getRandomProducts(String category) {
    return _dataSource.fetchRandomProducts(category: category);
  }
}
