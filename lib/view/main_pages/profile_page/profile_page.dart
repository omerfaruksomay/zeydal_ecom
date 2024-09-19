import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view_model/main_pages/profile_page/profile_page_view_model.dart';

import '../../../data/model/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ProfilePageViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildUserInfoSection(viewModel.userData),
              ),
              const Divider(),
              Expanded(child: _buildMenuList(context, viewModel)),
            ],
          );
        },
      ),
    ).animate().fade();
  }

  Row _buildUserInfoSection(User? userData) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Color(int.parse("0x60${userData?.avatarColor}")),
          radius: 38,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${userData?.name} ${userData?.surname}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userData!.email,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuList(BuildContext context, ProfilePageViewModel viewModel) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Siparişlerim'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Orders page navigation
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Bilgilerim'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            viewModel.goAccountInfo(context, viewModel.userData!);
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Kartlarım'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Payment methods page navigation
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Ayarlar'),
          subtitle:
              const Text('Şifre değiştirme, Kullanıcı bilgilerini güncelleme'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Settings page navigation
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Çıkış yap'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            viewModel.logout(context);
          },
        ),
        const Divider(),
      ],
    );
  }
}
