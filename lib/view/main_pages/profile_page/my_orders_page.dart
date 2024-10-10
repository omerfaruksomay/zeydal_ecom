import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/model/cart.dart';
import 'package:zeydal_ecom/view_model/main_pages/profile_page/my_orders_page_view_model.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Sipaişlerim')),
      body: Consumer<MyOrdersPageViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.carts.length,
            itemBuilder: (context, index) {
              Cart cart = viewModel.carts.reversed.toList()[index];
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cart.formattedCreatedAt,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: 'Toplam: ',
                                          style: TextStyle(fontSize: 16)),
                                      TextSpan(
                                        text:
                                            '${viewModel.getTotalPrice(cart).toStringAsFixed(2)} ₺',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  viewModel.goOrderDetails(
                                    context,
                                    cart,
                                    viewModel.getTotalPrice(cart),
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      'Detaylar',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                    )
                                  ],
                                ))
                          ],
                        ),
                        const Divider(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: _buildProductImages(cart),
                        ),
                        const SizedBox(height: 10),
                        Text("${cart.products.length} ürün teslim edildi."),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProductImages(Cart cart) {
    return Row(
      children: [
        for (var product in cart.products)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              children: [
                Container(
                    height: 75,
                    width: 75,
                    child: Image.asset('assets/images/product.jpg')),
              ],
            ),
          ),
      ],
    );
  }
}
