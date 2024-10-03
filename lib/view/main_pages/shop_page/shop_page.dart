import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/main_pages/shop_page/products_page.dart';
import 'package:zeydal_ecom/view_model/main_pages/shop_page/products_view_model.dart';
import 'package:zeydal_ecom/view_model/main_pages/shop_page/shop_page_view_model.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopPageViewModel>(
      builder: (context, viewModel, child) {
        return ListView(
          children: [
            _buildCategoryBanner(),
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => ProductsViewModel(""),
                        child: const ProductsPage(
                          category: 'Tüm Ürünler',
                        ),
                      ),
                    ),
                  );
                },
                child: _buildCategoryContainer(
                  'Tüm Ürünler',
                  'assets/images/product.jpg',
                ),
              ),
            ),
            ...viewModel.categories.map((category) {
              return Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => ProductsViewModel(category.name),
                          child: ProductsPage(
                            category: category.name,
                          ),
                        ),
                      ),
                    );
                  },
                  child: _buildCategoryContainer(
                    category.name,
                    'assets/images/product.jpg',
                  ),
                ),
              );
            }).toList(),
          ],
        ).animate().fade();
      },
    );
  }

  Widget _buildCategoryContainer(String catName, String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        width: 300,
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                catName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            Image.asset(
              imagePath,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBanner() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        width: 300,
        height: 120,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Yaz İndirimleri',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '%45 e varan indirimler',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
