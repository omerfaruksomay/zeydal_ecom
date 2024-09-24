import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';

import '../../../data/local_storage/storage.dart';
import '../../../data/model/user.dart';

class CheckoutPageViewModel with ChangeNotifier {
  final _storage = Storage();
  User? userData;

  CheckoutPageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadUserData();
    });
  }

  Future<void> _loadUserData() async {
    final userJson = await _storage.readSecureData('user_data');
    if (userJson != 'No data found!') {
      final Map<String, dynamic> jsonMap = jsonDecode(userJson);
      print("Parsed JSON: $jsonMap");
      userData = User.fromJson(jsonMap);
      notifyListeners();
    }
  }

  Future<void> processPayment(String cartId) async {
    final url = Uri.parse(
        '${ApiConstants.checkout}/$cartId/with-new-card'); // Replace with your backend URL
    final String token = await _storage.readSecureData('user_token');

    Map<String, dynamic> card = {
      "cardHolderName": "Ahmed Tayyib Kaya",
      "cardNumber": "5168880000000002",
      "expireMonth": "12",
      "expireYear": "2030",
      "cvc": "123",
    };

    // Create the data payload
    Map<String, dynamic> data = {
      "card": card,
    };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token, // Add your authorization token if needed
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('Payment successful');
        print('Response: ${response.body}');

      } else {
        print('Failed to process payment');
        print('Status Code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
  }
}
