import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/local_storage/storage.dart';

import '../../view/auth/login_page.dart';
import '../../view/widgets/custom_snacbar.dart';
import '../auth/login_view_model.dart';

class ProfilePageViewModel with ChangeNotifier {
  final _storage = Storage();
  Map<String, dynamic>? userData;




  ProfilePageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadUserData();
    });
  }



  void logout(context) async {
    await _storage.deleteSecureData('user_token');
    await _storage.deleteSecureData('user_data');
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: CustomSnackbar(
            message: 'Çıkış işlemi başarılı.',
            contentType: ContentType.success,
            title: 'Güle Güle!',
          ),
        ),
      );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginViewModel(),
                child: LoginPage(),
              )),
      (route) => false,
    );
  }

  Future<void> _loadUserData() async {
    final userJson = await _storage.readSecureData('user_data');
    if (userJson != 'No data found!') {
      userData = jsonDecode(userJson);
      notifyListeners(); // Dinleyen widget'lara haber ver
    }
  }
}
