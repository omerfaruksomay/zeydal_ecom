import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/shop_related/product_details.dart';
import 'package:zeydal_ecom/view_model/shop_related/products_view_model.dart';

import 'package:zeydal_ecom/data/model/product.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        centerTitle: true,
      ),
      body: Consumer<ProductsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            // Yüklenme durumu aktifse, bir indikatör göster
            return const Center(child: CircularProgressIndicator());
          }

          // Yüklenme tamamlandığında, ürünler gösteriliyor
          if (viewModel.products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return GridView.builder(
            itemCount: viewModel.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              Product product = viewModel.products[index];
              return _buildGridTile(product, context);
            },
          );
        },
      ),
    );
  }

  Widget _buildGridTile(Product product, BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).colorScheme.secondaryContainer,
      splashColor: Theme.of(context).colorScheme.secondaryContainer,
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => ProductDetails(product: product),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridTile(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/product.jpg'),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: product.brand,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextSpan(
                    text: ' ${product.name}',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${product.price.toString()} ₺',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 20),
            ),
          ],
        )),
      ),
    );
  }
}
