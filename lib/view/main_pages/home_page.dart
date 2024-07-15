import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildProductSlider(context),
            ),
            Container(
              height: 300,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSlider(BuildContext context) {
    return SizedBox(
      height: 310,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sale',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Super Summer Sale',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {
                    print("View All pressed");
                  },
                  child: Text('View All'))
            ],
          ),
          SizedBox(height: 10),
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
        Card(
          child: SizedBox(
            height: 150,
            width: 150,
            child: Image.asset(
              'assets/images/product.jpg',
              fit: BoxFit.fill,
            ),
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
