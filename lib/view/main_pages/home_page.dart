import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view_model/main_pages/home_page_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildHeroSection(),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _buildProductSlider(context, 'Zeytinyağı'),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: _buildProductSlider(context, 'Temizlik'),
            ),
          ],
        ),
      ),
    ).animate().fadeIn();
  }

  Widget _buildHeroSection() {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          Image.asset('assets/images/Olive.jpg'),
          const Positioned(
            left: 16,
            bottom: 50,
            child: Text(
              'Dijital Hal',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSlider(BuildContext context, String title) {
    return Consumer<HomePageViewModel>(
      builder: (context, viewModel, child) {
        return SizedBox(
          height: 310,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      print("View All pressed");
                    },
                    child: const Text('View All'),
                  )
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: viewModel.products.map((product) {
                    return _buildProductSliderItem(context, product.name,
                        product.price.toString(), product.images[0]);
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductSliderItem(
      BuildContext context, String brand, String price, String image) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset(
                'assets/images/product.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zeydal',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  brand,
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  "$price ₺",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
