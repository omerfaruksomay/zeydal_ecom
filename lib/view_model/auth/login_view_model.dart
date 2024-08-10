import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/auth/login_page.dart';
import 'package:zeydal_ecom/view_model/auth/register_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:zeydal_ecom/view_model/local_storage/storage.dart';
import '../../view/auth/register_page.dart';
import '../../view/main_layout.dart';
import '../../view/widgets/custom_snacbar.dart';
import '../main_layout_view_model.dart';

class LoginViewModel with ChangeNotifier {
  String _token = '';
  final _storage = Storage();

  final loginUrl = Uri.parse('https://10.0.2.2:3000/api/login');

  Future<void> login(String email, String password, context) async {
    var data = {
      'email': email,
      'password': password,
    };
    var response = await http.post(
      loginUrl,
      headers: {
        'Accept': 'application/json',
      },
      body: data,
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      _token = responseData['token'] ?? '';
      print('Token: $_token');
      await _storage.writeSecureData('user_token', _token);
      notifyListeners();

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
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
      print(responseData);
    } else {
      print('Login failed with status code: ${response.statusCode}');
      print(responseData);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
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
           child:  LoginPage(),
         )),
         (route) => false,
   );
   
  }
}
