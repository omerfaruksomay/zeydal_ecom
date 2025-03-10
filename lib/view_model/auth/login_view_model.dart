import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/repository/auth_repository.dart';
import 'package:zeydal_ecom/view/auth/forgot_password_page.dart';
import 'package:zeydal_ecom/view_model/auth/forgot_password_page_view_model.dart';
import 'package:zeydal_ecom/view_model/auth/register_view_model.dart';
import 'package:zeydal_ecom/data/local_storage/storage.dart';
import '../../view/auth/register_page.dart';
import '../../view/main_layout.dart';
import '../../view/widgets/custom_snacbar.dart';
import '../main_layout_view_model.dart';

class LoginViewModel with ChangeNotifier {
  String _token = '';
  final _storage = Storage();
  final _repo = AuthRepository();
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  LoginViewModel() {
    checkLoginStatus();
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      final responseData = await _repo.login(email, password);
      _token = responseData['token'] ?? '';
      final userData = responseData['user'];
      notifyListeners();

      // Token'ı saklama işlemleri burada yapılabilir
      await _storage.writeSecureData('user_token', _token);
      await _storage.writeSecureData('user_data', jsonEncode(userData));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: CustomSnackbar(
            message: 'Giriş işlemi başarılı.',
            contentType: ContentType.success,
            title: 'Hoşgeldiniz!',
          ),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => MainLayoutViewModel(),
                  child: const MainLayout(),
                )),
        (route) => false,
      );
    } catch (e) {
      print('Login failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: CustomSnackbar(
            message:
                'Giriş işlemi başarısız. Lütfen kontrol edip tekrar deneyiniz.',
            contentType: ContentType.failure,
            title: 'Opps!',
          ),
        ),
      );
    }
  }

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

  Future<void> checkLoginStatus() async {
    Storage _storage = Storage();
    String token = await _storage.readSecureData('user_token');
    if (token != 'No data found!') {
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }
    notifyListeners();
  }

  void goForgotPasswordPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => ForgotPasswordViewModel(),
          child:  ForgotPasswordPage(),
        ),
      ),
    );
  }
}
