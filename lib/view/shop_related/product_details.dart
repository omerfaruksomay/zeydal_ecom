import 'package:flutter/material.dart';
import 'package:zeydal_ecom/model/product.dart';
import 'package:zeydal_ecom/view/widgets/cutom_button.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: SizedBox(
            height: double.infinity,
            child: Stack(children: [
              SingleChildScrollView(
                child: Column(
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
                    const Divider(),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Ürün Açıklaması:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: product.definition,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    _buildProductSlider(context),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${product.price} tl',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 24),
                      ),
                      CustomButton(
                        label: 'Sepete Ekle',
                        labelColor: Colors.black,
                        buttonColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        minWidth: 100,
                        minHeight: 40,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Beğenebilecekleriniz',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
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
