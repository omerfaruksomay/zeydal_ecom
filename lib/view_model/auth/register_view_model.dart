import 'package:flutter/material.dart';

class RegisterViewModel with ChangeNotifier {
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

  void register(
    String email,
    String password,
    String name,
    String surname,
    String phone,
    String country,
    String city,
    String postalCode,
    String address,
  ) {
    print('email:$email '
        'password:$password '
        'name:$name '
        'surname:$surname '
        'telNo:$phone '
        'country:$country'
        ' City:$city '
        'postalCode:$postalCode '
        'address:$address');
  }
}
