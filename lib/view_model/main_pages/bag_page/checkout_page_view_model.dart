import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:zeydal_ecom/data/model/cart.dart';

import '../../../data/local_storage/storage.dart';
import '../../../data/model/bank_card.dart';
import '../../../data/model/user.dart';

class CheckoutPageViewModel with ChangeNotifier {
  final _storage = Storage();
  List<BankCard> _cards = [];
  BankCard? _selectedCard; // Seçilen kartı tutmak için değişken
  int? _selectedIndex;

  int? get selectedIndex => _selectedIndex;

  List<BankCard> get cards => _cards;

  BankCard? get selectedCard => _selectedCard;

  User? userData;

  CheckoutPageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadUserData();
      _fetchCards();
    });
  }

  // Kartları getiren fonksiyon
  Future<void> _fetchCards() async {
    final url = Uri.parse(ApiConstants.getAndCreateCards); // API URL'si
    final String token = await _storage.readSecureData('user_token');
    try {
      final response = await http.get(url, headers: {
        'Authorization': token, // Gerekliyse header ekleyin
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        List<BankCard> loadedCards = [];

        // JSON içindeki cardDetails listesini parse ediyoruz
        for (var cardJson in responseData['cardDetails']) {
          loadedCards.add(BankCard.fromJson(cardJson));
        }
        _cards = loadedCards;
        notifyListeners(); // Dinleyicilere yeni veri geldiğini bildir
      } else {
        throw Exception('Failed to load cards');
      }
      await Future.delayed(const Duration(seconds: 2));
    } catch (error) {
      throw Exception('Error fetching cards: $error');
    }
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

  void selectCard(BankCard? newCard) {
    _selectedCard = newCard;
    _selectedIndex = newCard != null ? _cards.indexOf(newCard) : null;
    notifyListeners();
  }

  Future<void> processPaymentWithRegisteredCard(
      BuildContext context, String cartId, int cardIndex) async {
    final String token = await _storage.readSecureData('user_token');
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/payments/$cartId/$cardIndex/with-registered-card-index');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token, // Kullanıcı tokeni
        },
      );

      if (response.statusCode == 200) {
        // Başarılı ödeme durumunda yapılacaklar
        print('Payment successful');
        print('Response: ${response.body}');
        Navigator.pop(context);
        notifyListeners();
      } else {
        // Hata durumu
        print('Failed to process payment');
        print('Status Code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      // Hata durumunda mesaj
      print('Error processing payment: $error');
      throw Exception('Failed to process payment');
    }
  }

/* Future<void> processPayment(String cartId, String name, String cardNum,
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
  }*/
}
