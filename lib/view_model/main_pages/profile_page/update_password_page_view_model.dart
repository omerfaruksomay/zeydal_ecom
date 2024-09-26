import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:http/http.dart' as http;

import '../../../data/local_storage/storage.dart';
import '../../../view/widgets/custom_snacbar.dart';

class UpdatePasswordPageViewModel with ChangeNotifier {
  final _storage = Storage();

  final updatePasswordUrl = Uri.parse(ApiConstants.updatePassword);

  Future<void> updatePassword(
    BuildContext context,
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    final String token = await _storage.readSecureData('user_token');
    final response = await http.put(
      updatePasswordUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token, // Kullanıcı doğrulama için token
      },
      body: jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      }),
    );

    if(response.statusCode == 200){
      print('Password has been changed successfully.');
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: CustomSnackbar(
              message: 'Şifre başarılı bir şekilde değiştirildi.',
              contentType: ContentType.success,
              title: 'Tebrikler',
            ),
          ),
        );
    } else {
      final responseData = json.decode(response.body);
      print('İşlem başarısız: $responseData');
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
