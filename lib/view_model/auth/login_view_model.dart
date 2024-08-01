import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view_model/auth/register_view_model.dart';
import 'package:http/http.dart' as http;
import '../../view/auth/register_page.dart';
import '../../view/main_layout.dart';
import '../main_layout_view_model.dart';

class LoginViewModel with ChangeNotifier {

  String _token = '';
  String _userId = '';

  final loginUrl = Uri.parse('https://10.0.2.2:3000/api/login');

  Future<void> login(String email,String password,context) async {
    try {
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
        _userId = responseData['user']['id'].toString();
        print('Token: $_token');
        print('User ID: $_userId');
        notifyListeners();



        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => MainLayoutViewModel(),
              child: const MainLayout(),
            ),
          ),
              (route) => false,
        );
        print(responseData);
      } else {
        print('Login failed with status code: ${response.statusCode}');
        print(responseData);
      }
    } catch (error) {
      print('Login error: $error');
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
}
