import 'package:zeydal_ecom/data/data_source/category_data_source.dart';

import '../model/category.dart';

class CategoryRepository{
  final _dataSource = CategoryDataSource();

  Future<List<Category>> getCategories(){
    return _dataSource.fetchCategories();
  }

}