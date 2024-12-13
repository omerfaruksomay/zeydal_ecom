import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/widgets/cutom_button.dart';
import 'package:zeydal_ecom/view_model/main_pages/bag_page/checkout_done_view_model.dart';

class CheckoutDonePage extends StatelessWidget {
  const CheckoutDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/checkout_done_anim.json',
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Siparişiniz başarılı bir şekilde oluşturuldu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            SizedBox(height: 50),
            builldGoMainPage(context)
          ],
        ),
      ),
    );
  }

  CustomButton builldGoMainPage(BuildContext context) {
    CheckoutDoneViewModel viewModel = Provider.of(context, listen: false);
    return CustomButton(
      label: "Ana sayfaya dön",
      labelColor: Colors.white,
      buttonColor: Theme.of(context).colorScheme.primary,
      minWidth: 300,
      minHeight: 50,
      onPressed: () {
        viewModel.goMainPAge(context);
      },
    );
  }
}
