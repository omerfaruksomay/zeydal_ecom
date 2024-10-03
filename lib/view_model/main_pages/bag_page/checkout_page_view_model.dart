import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:zeydal_ecom/data/model/cart.dart';

import '../../../data/local_storage/storage.dart';
import '../../../data/model/user.dart';

class CheckoutPageViewModel with ChangeNotifier {
  final _storage = Storage();
  User? userData;
  String? _selectedValueMonth;
  String? _selectedValueYear;

  String? get selectedValueMonth => _selectedValueMonth;

  String? get selectedValueYear => _selectedValueYear;

  final List<String> months = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
  ];
  final List<String> years = [
    "2024",
    "2025",
    "2026",
    "2027",
    "2028",
    "2029",
    "2030",
    "2031",
    "2032",
    "2033",
    "2034",
    "2035",
    "2036",
    "2037",
    "2038",
    "2039",
  ];

  void monthDropDownOnChange(String? newValue) {
    _selectedValueMonth = newValue;
  }

  void yearDropDownOnChange(String? newValue) {
    _selectedValueYear = newValue;
  }

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

  Future<void> processPayment(String cartId, String name, String cardNum,
      String expireMonth, String expireYear, String ccv) async {
    final url = Uri.parse(
        '${ApiConstants.checkout}/$cartId/with-new-card'); // Replace with your backend URL
    final String token = await _storage.readSecureData('user_token');

    Map<String, dynamic> card = {
      "cardHolderName": name,
      "cardNumber": cardNum,
      "expireMonth": expireMonth,
      "expireYear": expireYear,
      "cvc": ccv,
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
      notifyListeners();
    } else {
      print('Failed to process payment');
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }
}
