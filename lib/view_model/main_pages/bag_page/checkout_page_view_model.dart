import 'dart:convert';

import 'package:flutter/material.dart';

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

    print(
        "User JSON: $userJson"); // Burada verinin gelip gelmediğini kontrol et
    if (userJson != 'No data found!') {
      final Map<String, dynamic> jsonMap = jsonDecode(userJson);
      print(
          "Parsed JSON: $jsonMap"); // JSON verisinin düzgün parse edildiğini kontrol et
      userData = User.fromJson(jsonMap); // JSON'dan User nesnesi oluşturuyoruz
      notifyListeners(); // Dinleyen widget'lara haber ver
    }
  }
}
