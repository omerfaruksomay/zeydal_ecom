import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/repository/auth_repository.dart';
import 'package:zeydal_ecom/view/auth/login_page.dart';
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

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      final responseData = await _repo.login(email, password);
      _token = responseData['token'] ?? '';
      notifyListeners();

      // Token'ı saklama işlemleri burada yapılabilir
      await _storage.writeSecureData('user_token', _token);

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

  void logout(context) async {
    await _storage.deleteSecureData('user_token');
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
}
