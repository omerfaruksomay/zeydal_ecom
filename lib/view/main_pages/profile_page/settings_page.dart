import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view_model/main_pages/profile_page/settings_page_view_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          scale: 20,
        ),
      ),
      body: SafeArea(
        child: _buildMenuList(context),
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    SettingsPageViewModel viewModel = Provider.of(context, listen: false);
    return ListView(
      children: [
        ListTile(
          title: const Text('Şifre Değiştirme'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            viewModel.goUpdatePassword(context);
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Kullanıcı bilgilerini güncelle'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        const Divider(),
      ],
    );
  }
}
