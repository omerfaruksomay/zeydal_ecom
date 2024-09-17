import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/widgets/custom_grid_item.dart';
import 'package:zeydal_ecom/view_model/main_pages/profile_page_view_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Consumer<ProfilePageViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  _buildUserInfoSection(viewModel.userData),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Expanded(child: _buildMenuGrid(context)),
                ],
              );
            },
          )),
    ).animate().fade();
  }

  Row _buildUserInfoSection(userData) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Color(int.parse("0x60${userData['avatarColor']}")),
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
              userData['name'] + " " + userData['surname'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userData['email'],
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

  Widget _buildMenuGrid(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: [
        _buildOrdersGridItem(context),
        _buildAdressesGridItem(context),
        _buildCardsGridItem(context),
        _buildSettingsGridItem(context),
      ],
    );
  }

  CustomGridItem _buildSettingsGridItem(BuildContext context) {
    ProfilePageViewModel viewModel = Provider.of(context, listen: false);
    return CustomGridItem(
      title: 'Ayarlar',
      clickColor: Theme.of(context).colorScheme.primaryContainer,
      icon: Icons.settings_outlined,
      iconSize: 50,
      onTap: () {
        viewModel.logout(context);
      },
    );
  }

  CustomGridItem _buildCardsGridItem(BuildContext context) {
    return CustomGridItem(
      title: 'Kartlarım',
      clickColor: Theme.of(context).colorScheme.primaryContainer,
      icon: Icons.credit_card,
      iconSize: 50,
      onTap: () {
        print('Cards clicked');
      },
    );
  }

  Widget _buildAdressesGridItem(BuildContext context) {
    return CustomGridItem(
      title: 'Adreslerim',
      clickColor: Theme.of(context).colorScheme.primaryContainer,
      icon: Icons.location_on_outlined,
      iconSize: 50,
      onTap: () {
        print('adresses clicked');
      },
    );
  }

  Widget _buildOrdersGridItem(BuildContext context) {
    return CustomGridItem(
      title: 'Siparişlerim',
      clickColor: Theme.of(context).colorScheme.primaryContainer,
      icon: Icons.list_alt_rounded,
      iconSize: 50,
      onTap: () {
        print('orders Clicked');
      },
    );
  }
}
