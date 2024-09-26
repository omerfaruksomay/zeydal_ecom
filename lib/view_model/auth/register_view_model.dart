import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';
import 'package:zeydal_ecom/view/widgets/custom_snacbar.dart';

class RegisterViewModel with ChangeNotifier {
  final registerUrl = Uri.parse(ApiConstants.registerUrl);
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
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: CustomSnackbar(
              message:
                  'Hesabınız oluşturuldu. Lütfen $email mailinize gelen doğrulama maili ile hesabınızı doğrulayınız.',
              contentType: ContentType.success,
              title: 'Tebrikler',
            ),
          ),
        );
    } else {
      final responseData = json.decode(response.body);
      print('Kayıt işlemi başarısız: $responseData');
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
