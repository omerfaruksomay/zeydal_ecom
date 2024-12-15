import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/model/product.dart';
import 'package:zeydal_ecom/view/widgets/cutom_button.dart';
import 'package:zeydal_ecom/view_model/main_pages/shop_page/product_details_view_model.dart';

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
                      _buildOrderButton(context),
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

  CustomButton _buildOrderButton(BuildContext context) {
    ProductDetailsViewModel viewModel = Provider.of(context, listen: false);
    return CustomButton(
      label: 'Sepete Ekle',
      labelColor: Colors.black,
      buttonColor: Theme.of(context).colorScheme.primaryContainer,
      minWidth: 100,
      minHeight: 40,
      onPressed: () {
        viewModel.addProductToCart(product.id,context);
      },
    );
  }

  Widget _buildProductSlider(BuildContext context) {
    return Consumer<ProductDetailsViewModel>(
      builder: (context, viewModel, child) {
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
                        'Beğenebilecekleriniz',
                        style: TextStyle(
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
                      child: const Text('View All'))
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: viewModel.products.map((product) {
                    return _buildProductSliderItem(context, product.name,
                        product.seller['SellerName'], product.price.toString(),product.images[0]);
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
      BuildContext context, String name, String brand, String price,image) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Image.asset('assets/images/product.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    );
  }
}
