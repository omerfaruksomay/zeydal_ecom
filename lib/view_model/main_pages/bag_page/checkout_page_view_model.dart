import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:zeydal_ecom/view/main_pages/bag_page/checkout_done.dart';
import 'package:zeydal_ecom/view_model/main_pages/bag_page/checkout_done_view_model.dart';

import '../../../data/local_storage/storage.dart';
import '../../../data/model/bank_card.dart';
import '../../../data/model/user.dart';
import '../../../view/widgets/custom_snacbar.dart';

class CheckoutPageViewModel with ChangeNotifier {
  final _storage = Storage();
  List<BankCard> _cards = [];
  BankCard? _selectedCard; // Seçilen kartı tutmak için değişken
  int? _selectedIndex;
  bool _useSavedCards = true; // Başlangıçta kayıtlı kartlar gösterilecek

  bool get useSavedCards => _useSavedCards;

  // Butonun label'ını döndüren metot
  String get buttonLabel =>
      _useSavedCards ? "Başka kartla öde" : "Kayıtlı kartlarım";

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

  // Durumu tersine çeviren metot
  void togglePaymentMethod() {
    _useSavedCards = !_useSavedCards;
    notifyListeners();
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: CustomSnackbar(
              message: 'Ödeme başarılı bir şekilde alındı.',
              contentType: ContentType.success,
              title: 'Tebrikler!',
            ),
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => CheckoutDoneViewModel(),
                child: const CheckoutDonePage(),
              )),
              (route) => false,
        );
        notifyListeners();
      } else {
        // Hata durumu
        print('Failed to process payment');
        print('Status Code: ${response.statusCode}');
        print('Response: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: CustomSnackbar(
              message: 'Oops!',
              contentType: ContentType.failure,
              title: 'Ödeme yapılırken bir hata oluştu.',
            ),
          ),
        );
      }
    } catch (error) {
      // Hata durumunda mesaj
      print('Error processing payment: $error');
      throw Exception('Failed to process payment');
    }
  }

  Future<void> processPayment(BuildContext context, String cartId, String name,
      String cardNum, String expireMonth, String expireYear, String ccv) async {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: CustomSnackbar(
            message: 'Ödeme başarılı bir şekilde alındı.',
            contentType: ContentType.success,
            title: 'Tebrikler!',
          ),
        ),
      );
      Navigator.pop(context);
      notifyListeners();
    } else {
      print('Failed to process payment');
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: CustomSnackbar(
            message: 'Oops!',
            contentType: ContentType.failure,
            title: 'Ödeme yapılırken bir hata oluştu.',
          ),
        ),
      );
    }
  }
}
