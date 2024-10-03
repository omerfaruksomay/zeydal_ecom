import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:zeydal_ecom/data/local_storage/storage.dart';
import '../../../data/model/bank_card.dart';

class CardsPageViewModel with ChangeNotifier {
  final Storage _storage = Storage();

  List<BankCard> _cards = [];

  List<BankCard> get cards => _cards;

  CardsPageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchCards();
    });
  }

  // Kartları getiren fonksiyon
  Future<void> _fetchCards() async {
    final url = Uri.parse(ApiConstants.getCards); // API URL'si
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
    } catch (error) {
      throw Exception('Error fetching cards: $error');
    }
  }

  String getCardImage(String cardAssociation) {
    if (cardAssociation == 'VISA') {
      return 'assets/images/visa_card.png';
    } else if (cardAssociation == 'MASTER') {
      return 'assets/images/master.png';
    } else {
      return 'assets/images/default.png'; // Diğer kartlar için varsayılan görüntü
    }
  }

}
