import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/model/product.dart';
import 'package:zeydal_ecom/view/main_pages/shop_page/product_details.dart';
import 'package:zeydal_ecom/view_model/main_pages/shop_page/product_details_view_model.dart';
import 'package:zeydal_ecom/view_model/main_pages/shop_page/products_view_model.dart';

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
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black12,
            width: 2,
          ),
        ),
        child: InkWell(
          highlightColor: Theme.of(context).colorScheme.secondaryContainer,
          splashColor: Theme.of(context).colorScheme.secondaryContainer,
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => ChangeNotifierProvider(
                create: (context) => ProductDetailsViewModel(),
                child: ProductDetails(
                  product: product,
                ),
              ),
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
                        text: product.seller['SellerName'],
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
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
