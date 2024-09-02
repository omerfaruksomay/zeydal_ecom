import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/main_pages/bag_page.dart';
import 'package:zeydal_ecom/view/main_pages/home_page.dart';
import 'package:zeydal_ecom/view/main_pages/profile_page.dart';
import 'package:zeydal_ecom/view/main_pages/shop_page/shop_page.dart';
import 'package:zeydal_ecom/view_model/auth/login_view_model.dart';
import 'package:zeydal_ecom/view_model/main_pages/shop_page/shop_page_view_model.dart';

import 'main_pages/home_page_view_model.dart';

class MainLayoutViewModel with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  List<Widget> pages = [
    ChangeNotifierProvider(
        create: (context) => HomePageViewModel(), child: const HomePage()),
    ChangeNotifierProvider(
        create: (context) => ShopPageViewModel(), child: const ShopPage()),
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
