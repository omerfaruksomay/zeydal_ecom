import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zeydal_ecom/data/api_constants/api_constants.dart';

class AuthDataSource {
  Future<Map<String, dynamic>> login(String email, String password) async {
    var data = {
      'email': email,
      'password': password,
    };

    var response = await http.post(
      Uri.parse(ApiConstants.loginUrl),
      headers: {
        'Accept': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }
}
