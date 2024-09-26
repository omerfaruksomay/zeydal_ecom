import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';

import '../../view/widgets/custom_snacbar.dart';

class ForgotPasswordViewModel with ChangeNotifier {
  final forgotPasswordUrl = Uri.parse(ApiConstants.forgotPasswordUrl);

  Future<void> sendPasswordResetEmail(BuildContext context,String email) async {
    final response = await http.post(
      forgotPasswordUrl,
      headers:{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('sıfırlama şifresi yollandı');
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: CustomSnackbar(
              message: '$email mailinize gelen şifre ile giriş yapabilirsiniz.',
              contentType: ContentType.success,
              title: 'Tebrikler',
            ),
          ),
        );
    } else {
      final responseData = json.decode(response.body);
      print('Kayıt işlemi başarısız: $responseData');
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: CustomSnackbar(
              message: response.body,
              contentType: ContentType.failure,
              title: 'Opps!',
            ),
          ),
        );
    }
  }
}
