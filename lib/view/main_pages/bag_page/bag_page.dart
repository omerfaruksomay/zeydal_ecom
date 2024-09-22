import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/model/product.dart';
import 'package:zeydal_ecom/view/widgets/cutom_button.dart';
import 'package:zeydal_ecom/view_model/main_pages/bag_page/bag_page_view_model.dart';

class BagPage extends StatelessWidget {
  const BagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BagPageViewModel>(
      builder: (context, viewModel, child) {
        // Cart ve products null olup olmadığını kontrol edin
        if (viewModel.cart == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.cart!.products.isEmpty) {
          return const Center(
              child: Text(
            'Sepetinizde ürün yok.',
            style: TextStyle(fontSize: 24),
          ));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.cart?.products.length,
                itemBuilder: (context, index) {
                  Product product = viewModel.cart!.products[index];
                  return _buildCartList(context, viewModel, product);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Toplam Tutar:",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        Text(
                          '${viewModel.getTotalPrice()} ${viewModel.cart!.currency}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    label: "Sepeti Onayla",
                    labelColor: Colors.white,
                    buttonColor: Theme.of(context).colorScheme.primary,
                    minWidth: 350,
                    minHeight: 50,
                    onPressed: () {
                      viewModel.goCheckoutPage(
                          context, viewModel.cart!, viewModel.getTotalPrice());
                    },
                  )
                ],
              ),
            ),
          ],
        );
      },
    ).animate().fade();
  }

  Widget _buildCartList(context, BagPageViewModel viewModel, Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://10.0.2.2:3000/${product.images[0]}',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: product.brand,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text: " ${product.name}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${product.price} ₺",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                    _buildDeleteButton(context, viewModel, product.id),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  IconButton _buildDeleteButton(
      context, BagPageViewModel viewModel, String productId) {
    return IconButton(
      onPressed: () async {
        String cartId = viewModel.cart!.id;
        await viewModel.removeProductFromCart(context, cartId, productId);
      },
      icon: const Icon(Icons.delete),
    );
  }
}
