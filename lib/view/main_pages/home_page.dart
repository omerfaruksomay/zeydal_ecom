import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
              child: _buildProductSlider(context, 'Zeytin Yağı'),
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
              'ZEYDAL OLIVE OIL',
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
                  const Text(
                    'Super Summer Sale',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {
                    print("View All pressed");
                  },
                  child: const Text('View All'))
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildProductSliderItem(context),
                const SizedBox(width: 20),
                _buildProductSliderItem(context),
                const SizedBox(width: 20),
                _buildProductSliderItem(context),
                const SizedBox(width: 20),
                _buildProductSliderItem(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSliderItem(BuildContext context) {
    return Column(
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
            const Text(
              'Ayvalık Zeydal Natural Sızma',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
            const Text(
              'Zeytin yağı 4lt',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '₺ 6.000',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }
}
