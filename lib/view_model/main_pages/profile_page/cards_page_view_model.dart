import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:zeydal_ecom/data/local_storage/storage.dart';
import 'package:zeydal_ecom/view/main_pages/profile_page/create_card_page.dart';
import 'package:zeydal_ecom/view_model/main_pages/profile_page/create_card_page_view_model.dart';
import '../../../data/model/bank_card.dart';
import '../../../view/widgets/custom_snacbar.dart';

class CardsPageViewModel with ChangeNotifier {
  final Storage _storage = Storage();
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  List<BankCard> _cards = [];

  List<BankCard> get cards => _cards;

  CardsPageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    } catch (error) {
      throw Exception('Error fetching cards: $error');
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      _isLoading = false;
      print(_cards.length);
      notifyListeners();
    }
  }

  String getCardImage(String cardAssociation) {
    if (cardAssociation == 'VISA') {
      return 'assets/images/visa_card.png';
    } else if (cardAssociation == 'MASTER_CARD') {
      return 'assets/images/master.png';
    } else {
      return ''; // Diğer kartlar için varsayılan görüntü
    }
  }

  Future<void> deleteCard(BuildContext context, String cardToken) async {
    final url = Uri.parse(ApiConstants.deleteCard); // Kart silme API URL'si
    final String token = await _storage.readSecureData('user_token');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': token, // Gerekliyse header ekleyin
        'Content-Type': 'application/json', // JSON verisi göndereceğiz
      },
      body: json.encode({
        'cardToken': cardToken, // Gönderilecek body içeriği
      }),
    );

    if (response.statusCode == 200) {
      // Kart silme başarılıysa kartları tekrar fetch et
      _fetchCards();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: CustomSnackbar(
            message: '',
            contentType: ContentType.warning,
            title: 'Kart başarılı bir şekilde silindi.',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: CustomSnackbar(
            message: '',
            contentType: ContentType.warning,
            title: 'Kart başarılı bir şekilde silindi.',
          ),
        ),
      );
    }
  }

  void goCreateCardPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => CreateCardPageViewModel(),
          child: CreateCardPage(),
        ),
      ),
    ).then((value) {
      _cards.clear();
      _isLoading = true;
      _fetchCards();
    });
  }
}
