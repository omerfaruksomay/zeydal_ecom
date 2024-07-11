import 'package:flutter/material.dart';
import 'package:zeydal_ecom/view/main_pages/bag_page.dart';
import 'package:zeydal_ecom/view/main_pages/home_page.dart';
import 'package:zeydal_ecom/view/main_pages/profile_page.dart';
import 'package:zeydal_ecom/view/main_pages/shop_page.dart';

class MainLayoutViewModel with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  List<Widget> pages = [
    const HomePage(),
    const ShopPage(),
    const BagPage(),
    const ProfilePage(),
  ];

  void navbarOnTap(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
