import 'package:flutter/material.dart';
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';

import '../../../../data/model/cart.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage(
      {super.key, required this.cart, required this.totalPrice});

  final Cart cart;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sipariş detay'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildOrderDetails(context),
            _buildProductsContainer(context),
          ],
        ),
      ),
    );
  }

  Container _buildProductsContainer(BuildContext context) {
    return Container(
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
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            for (var product in cart.products)
              _buildProductList(context, product),
          ],
        ),
      ),
    );
  }

  Padding _buildProductList(BuildContext context, product) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                ApiConstants.url + "/" + product['productId']['images'][0],
                width: 120,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    "Zeydal",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product['productId']['name'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Adet: ', style: TextStyle(fontSize: 16)),
                        TextSpan(
                          text: product['quantity'].toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Tutar: ', style: TextStyle(fontSize: 16)),
                        TextSpan(
                          text:
                              "${product['productId']['price'] * product['quantity']} ₺",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context) {
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
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Sipraiş No: ', style: TextStyle(fontSize: 18)),
                    TextSpan(
                      text: cart.id,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Sipraiş Tarihi: ',
                        style: TextStyle(fontSize: 18)),
                    TextSpan(
                      text: cart.formattedCreatedAt,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Sipraiş Özeti: ',
                        style: TextStyle(fontSize: 18)),
                    TextSpan(
                      text: '${cart.products.length} ürün teslim edildi.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Toplam Tutar: ', style: TextStyle(fontSize: 18)),
                    TextSpan(
                      text: '${totalPrice.toStringAsFixed(2)} ₺',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
