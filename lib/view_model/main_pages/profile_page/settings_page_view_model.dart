import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view_model/main_pages/profile_page/update_password_page_view_model.dart';

import '../../../view/main_pages/profile_page/update_password_page.dart';

class SettingsPageViewModel with ChangeNotifier {
  void goUpdatePassword(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => UpdatePasswordPageViewModel(),
            child: UpdatePasswordPage(),
          ),
        ));
  }
}
