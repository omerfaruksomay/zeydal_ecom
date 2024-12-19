import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/widgets/custom_app_bar.dart';
import 'package:zeydal_ecom/view/widgets/custom_textfield.dart';
import 'package:zeydal_ecom/view/widgets/cutom_button.dart';
import 'package:zeydal_ecom/view_model/main_pages/profile_page/create_card_page_view_model.dart';

class CreateCardPage extends StatelessWidget {
  CreateCardPage({super.key});

  final TextEditingController _cardAliasController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expireMonthController = TextEditingController();
  final TextEditingController _expireYearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _cardAliasController,
                              label: 'Ödeme Sırasında Gösterilecek Kart İsmi'),
                          const SizedBox(height: 16),
                          CustomTextField(
                              controller: _cardHolderNameController,
                              label: 'Kart Üzerindeki İsim'),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _cardNumberController,
                            label: 'Kart No',
                            keyboardType: TextInputType.number,
                          ),
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
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              _buildSaveCardButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveCardButton(BuildContext context) {
    CreateCardPageViewModel viewModel = Provider.of(context, listen: false);
    return CustomButton(
        onPressed: () => viewModel.addCard(
              context,
              cardAlias: _cardAliasController.text,
              cardHolderName: _cardHolderNameController.text,
              cardNumber: _cardNumberController.text,
              expireMonth: _expireMonthController.text,
              expireYear: _expireYearController.text,
            ),
        label: 'Kartımı Kaydet',
        labelColor: Colors.white,
        buttonColor: Theme.of(context).colorScheme.primary,
        minWidth: double.infinity,
        minHeight: 50);
  }
}
