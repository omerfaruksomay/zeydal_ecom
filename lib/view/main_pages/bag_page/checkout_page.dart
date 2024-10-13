import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/model/bank_card.dart';
import 'package:zeydal_ecom/data/model/user.dart';
import 'package:zeydal_ecom/view/widgets/custom_textfield.dart';
import 'package:zeydal_ecom/view/widgets/cutom_button.dart';
import 'package:zeydal_ecom/view_model/main_pages/bag_page/checkout_page_view_model.dart';

import '../../../data/model/cart.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key, required this.cart, required this.totalAmount});

  final Cart cart;
  final double totalAmount;
  final TextEditingController _cardNumController = TextEditingController();
  final TextEditingController _cardOwnerNameController =
      TextEditingController();
  final TextEditingController _ccvController = TextEditingController();
  final TextEditingController _expireMonthController = TextEditingController();
  final TextEditingController _expireYearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/images/logo.png',
            scale: 20,
          ),
        ),
        body: Consumer<CheckoutPageViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: double.infinity,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildAdressSection(context, viewModel.userData!),
                          const SizedBox(height: 10),
                          _buildCartInfoSection(context),
                          const SizedBox(height: 10),
                          _buildCardInfo(context),
                          const SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.white,
                        child: _buildCheckoutButton(context),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _buildCardInfo(BuildContext context) {
    CheckoutPageViewModel viewModel = Provider.of(context, listen: false);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Text(
                  'Kart bilgileri',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: TextButton(
                  onPressed: () => viewModel.togglePaymentMethod(),
                  child: Text(
                    viewModel.buttonLabel,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
          const Divider(),
          viewModel.useSavedCards
              ? _buildRegisteredCards(viewModel)
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _cardOwnerNameController,
                              label: 'Kart Üzerindeki İsim'),
                          const SizedBox(height: 16),
                          CustomTextField(
                              controller: _cardNumController, label: 'Kart No'),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: _expireMonthController,
                                  label: 'Ay',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CustomTextField(
                                  controller: _expireYearController,
                                  label: 'Yıl',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CustomTextField(
                                  controller: _ccvController,
                                  label: 'ccv',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildRegisteredCards(CheckoutPageViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<BankCard>(
            items: viewModel.cards
                .map<DropdownMenuItem<BankCard>>((BankCard card) {
              return DropdownMenuItem<BankCard>(
                value: card,
                child: Text(
                    '${card.cardAlias} kartım - ${card.lastFourDigits} ile biten'), // Son 4 hane gösterilir
              );
            }).toList(),
            onChanged: (BankCard? newValue) {
              viewModel.selectCard(newValue); // Kart seçimi değiştiğinde
            },
            value: viewModel.selectedCard,
            hint: Text('Bir kart seçiniz'),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    CheckoutPageViewModel viewModel = Provider.of(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Toplam:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey),
                ),
                TextSpan(
                  text: " ${totalAmount.toStringAsFixed(2)}₺",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green),
                ),
              ],
            ),
          ),
          CustomButton(
            label: "Sepeti Onayla",
            labelColor: Colors.white,
            buttonColor: Theme.of(context).colorScheme.primary,
            minWidth: 225,
            minHeight: 50,
            onPressed: () {
              if (viewModel.useSavedCards) {
                viewModel.processPaymentWithRegisteredCard(
                    context, cart.id, viewModel.selectedIndex!);
              } else {
                viewModel.processPayment(
                  context,
                  cart.id,
                  _cardOwnerNameController.text,
                  _cardNumController.text,
                  _expireMonthController.text,
                  _expireYearController.text,
                  _ccvController.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartInfoSection(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Text(
              'Sipraiş Özeti',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cart.products.length,
                  itemBuilder: (context, index) {
                    final product = cart.products[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product['quantity']} x ${product['productId']['name']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          "${product['productId']['price'] * product['quantity']}₺",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Toplam tutar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      "${totalAmount.toStringAsFixed(2)}₺",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdressSection(BuildContext context, User user) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Text(
              'Teslimat Adresi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.name} ${user.surname}",
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  user.address!,
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
