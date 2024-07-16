import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view_model/auth/register_view_model.dart';

import '../../view/auth/register_page.dart';

class LoginViewModel with ChangeNotifier {


  void register(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => RegisterViewModel(),
          child: RegisterPage(),
        ),
      ),
    );
  }


}
