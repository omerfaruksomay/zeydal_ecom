import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                          SizedBox(
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Text(
              'Kart bilgileri',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: CustomTextField(
                controller: _cardOwnerNameController,
                label: "Kart üzerindek isim",
                keyboardType: TextInputType.number),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: CustomTextField(
                controller: _cardNumController,
                label: "Kart No",
                keyboardType: TextInputType.number),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              children: [
                Expanded(child: _buildExpireMonthDropDown(context)),
                Expanded(child: _buildExpireYearDropDown(context)),
                Expanded(
                  child: CustomTextField(
                      controller: _ccvController,
                      label: "CCV",
                      keyboardType: TextInputType.number),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpireMonthDropDown(BuildContext context) {
    CheckoutPageViewModel viewModel = Provider.of(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Ay',
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        items: viewModel.months
            .map<DropdownMenuItem>((String value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
        onChanged: (value) {
          viewModel.monthDropDownOnChange(value);
        },
      ),
    );
  }

  Widget _buildExpireYearDropDown(BuildContext context) {
    CheckoutPageViewModel viewModel = Provider.of(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Yıl',
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        items: viewModel.years
            .map<DropdownMenuItem>((String value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
        onChanged: (value) {
          viewModel.yearDropDownOnChange(value);
        },
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
                  text: " $totalAmount₺",
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
              viewModel.processPayment(
                cart,
                cart.id,
                _cardOwnerNameController.text,
                _cardNumController.text,
                viewModel.selectedValueMonth!,
                viewModel.selectedValueYear!,
                _ccvController.text,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartInfoSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondaryContainer),
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
                          product['productId']['name'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          "${product['productId']['price']}₺",
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
                      "$totalAmount₺",
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
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.secondaryContainer,
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
