import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view_model/shop_related/all_products_view_model.dart';

import '../../model/product.dart';

class AllProductPage extends StatelessWidget {
  const AllProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tüm Ürünler'),
        centerTitle: true,
      ),
      body: Consumer<AllProductsViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.products.length,
            itemBuilder: (context, index) {
              Product product = viewModel.products[index];
              return ListTile(
                title: Text(product.name),
              );
            },
          );
        },
      ),
    );
  }
}
