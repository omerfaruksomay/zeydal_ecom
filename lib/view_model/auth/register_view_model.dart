import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterViewModel with ChangeNotifier {
  final loginUrl = Uri.parse('https://10.0.2.2:3000/api/register');
  String? _selectedValueCountry;
  String? _selectedValueCity;

  String? get selectedValueCity => _selectedValueCity;

  String? get selectedValueCountry => _selectedValueCountry;

  final List<String> countries = [
    "Türkiye",
    "Almanya",
    "Amerika",
    "İngiltere",
  ];
  final List<String> cities = [
    "İstanbul",
    "Ankara",
    "İzmir",
    "Trabzon",
    "Rize",
    "Balıkesir",
  ];

  void countryDropDownOnChange(String? newValue) {
    _selectedValueCountry = newValue;
  }

  void cityDropDownOnChange(String? newValue) {
    _selectedValueCity = newValue;
  }

  Future<void> registerUser(
    String email,
    String password,
    String name,
    String surname,
    String phone,
    String country,
    String city,
    String postalCode,
    String address,
    BuildContext context,
  ) async {
    final registerUrl = loginUrl;

    final Map<String, dynamic> data = {
      'email': email,
      'name': name,
      'surname': surname,
      'phoneNumber': phone,
      'password': password,
      'address': address,
      'city': city,
      'country': country,
      'zipCode': postalCode,
    };

    try {
      final response = await http.post(
        registerUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Kullanıcı oluşturuldu: $responseData');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Doğrulama maili gönderildi. Mailinizi kontrol ediniz.')),
        );
      } else {
        final responseData = json.decode(response.body);
        print('Kayıt işlemi başarısız: $responseData');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Kayıt işlemi başarısız. Hata: ${responseData['message']}')),
        );
      }
    } catch (error) {
      print('Kayıt işlemi sırasında hata oluştu: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt işlemi sırasında hata oluştu.')),
      );
    }
  }
}
