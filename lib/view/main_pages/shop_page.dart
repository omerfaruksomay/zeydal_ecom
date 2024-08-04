import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/shop_related/all_products_page.dart';
import 'package:zeydal_ecom/view_model/shop_related/all_products_view_model.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildCategoryBanner(),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => AllProductsViewModel(),
                  child: const AllProductPage(),
                ),
              ),
            );
          },
          child: _buildCategoryContainer(
              'Tüm Ürünler', 'assets/images/product.jpg'),
        ),
        InkWell(
          onTap: () {
            print('Zeytin Yağı');
          },
          child: _buildCategoryContainer(
              'Zeytin Yağı', 'assets/images/product.jpg'),
        ),
        InkWell(
          onTap: () {
            print('Temizlik');
          },
          child:
              _buildCategoryContainer('Temizlik', 'assets/images/product.jpg'),
        ),
      ],
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
            borderRadius: BorderRadius.circular(10), color: Colors.red),
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
