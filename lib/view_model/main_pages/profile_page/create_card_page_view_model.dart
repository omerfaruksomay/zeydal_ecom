import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../data/api_constants/api_constants.dart';
import '../../../data/local_storage/storage.dart';
import '../../../view/widgets/custom_snacbar.dart';

class CreateCardPageViewModel with ChangeNotifier {
  final Storage _storage = Storage();

  Future<void> addCard(
    BuildContext context, {
    required String cardAlias,
    required String cardHolderName,
    required String cardNumber,
    required String expireMonth,
    required String expireYear,
  }) async {
    final url = Uri.parse(ApiConstants.getAndCreateCards); // API URL
    final String token = await _storage.readSecureData('user_token');

    final cardData = {
      'card': {
        'cardAlias': cardAlias,
        'cardHolderName': cardHolderName,
        'cardNumber': cardNumber,
        'expireMonth': expireMonth,
        'expireYear': expireYear,
      },
    };

    // POST isteği yapılıyor
    final response = await http.post(
      url,
      headers: {
        'Authorization': token, // Token ekleniyor
        'Content-Type': 'application/json',
      },
      body: json.encode(cardData),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: CustomSnackbar(
            message: '',
            contentType: ContentType.success,
            title: 'Kart başarılı bir şekilde kayıt edildi.',
          ),
        ),
      );
      // Eğer başarılı ise geri dönen veriyi işle
      print('Card added successfully: $responseData');
      notifyListeners();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: CustomSnackbar(
            message: '',
            contentType: ContentType.failure,
            title: 'Kart eklenirken bir hata oluştu.',
          ),
        ),
      );
    }
  }
}
