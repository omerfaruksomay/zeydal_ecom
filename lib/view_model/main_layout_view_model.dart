import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/main_pages/bag_page.dart';
import 'package:zeydal_ecom/view/main_pages/home_page.dart';
import 'package:zeydal_ecom/view/main_pages/profile_page.dart';
import 'package:zeydal_ecom/view/main_pages/shop_page.dart';
import 'package:zeydal_ecom/view_model/auth/login_view_model.dart';

class MainLayoutViewModel with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  List<Widget> pages = [
    const HomePage(),
    const ShopPage(),
    const BagPage(),
    ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: const ProfilePage(),
    ),
  ];

  void navbarOnTap(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
