import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/data/local_storage/storage.dart';
import 'package:zeydal_ecom/view/main_pages/profile_page/user_details_page.dart';

import '../../../data/model/user.dart';
import '../../../view/auth/login_page.dart';
import '../../../view/widgets/custom_snacbar.dart';
import '../../auth/login_view_model.dart';

class ProfilePageViewModel with ChangeNotifier {
  final _storage = Storage();
  User? userData;

  ProfilePageViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadUserData();
    });
  }

  void logout(context) async {
    await _storage.deleteSecureData('user_token');
    await _storage.deleteSecureData('user_data');
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: CustomSnackbar(
            message: 'Çıkış işlemi başarılı.',
            contentType: ContentType.success,
            title: 'Güle Güle!',
          ),
        ),
      );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
                create: (context) => LoginViewModel(),
                child: LoginPage(),
              )),
      (route) => false,
    );
  }

  Future<void> _loadUserData() async {
    final userJson = await _storage.readSecureData('user_data');
    final token = await _storage.readSecureData('user_token');
    print(token);
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

  void goAccountInfo(context, User userData) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsPage(
            userData: userData,
          ),
        ));
  }
}
