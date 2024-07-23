import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                child: Text('Yağ'),
              ),
              Tab(
                child: Text('Temizlik'),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: TabBarView(
                children: [
                  _buildProductsGrid(context),
                  _buildProductsGrid(context),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fade();
  }

  GridView _buildProductsGrid(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 70,
      ),
      children: [
        _buildShopItem(context),
        _buildShopItem(context),
        _buildShopItem(context),
        _buildShopItem(context),
      ],
    );
  }

  Widget _buildShopItem(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      highlightColor: Theme.of(context).colorScheme.primaryContainer,
      splashColor: Theme.of(context).colorScheme.primaryContainer,
      onTap: () {
        print('item clicked');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 162,
            child: Image.asset('assets/images/product.jpg'),
          ),
          const Text(
            'Ayvalık Natural Sızma',
            style: TextStyle(fontSize: 14),
          ),
          const Text(
            'Zeytin Yağı 4 Lt',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '₺ 6.000',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
