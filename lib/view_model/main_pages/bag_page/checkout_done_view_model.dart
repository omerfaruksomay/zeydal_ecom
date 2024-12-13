import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/main_layout.dart';
import 'package:zeydal_ecom/view_model/main_layout_view_model.dart';

class CheckoutDoneViewModel with ChangeNotifier {
  void goMainPAge(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => MainLayoutViewModel(),
            child: const MainLayout(),
          )),
          (route) => false,
    );
  }
}
