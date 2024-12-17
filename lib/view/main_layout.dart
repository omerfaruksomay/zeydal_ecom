import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/widgets/custom_app_bar.dart';
import 'package:zeydal_ecom/view_model/main_layout_view_model.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainLayoutViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        appBar: CustomAppbar(),
        body: viewModel.pages[viewModel.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "AnaSayfa",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Kategoriler",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: "Sepet",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: "Hesap",
            ),
          ],
          currentIndex: viewModel.selectedIndex,
          onTap: viewModel.navbarOnTap,
        ),
      ),
    );
  }
}
