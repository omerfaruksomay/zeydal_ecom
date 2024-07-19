import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zeydal_ecom/view/widgets/custom_grid_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            _buildUserInfoSection(),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Expanded(child: _buildMenuGrid(context)),
          ],
        ),
      ),
    ).animate().fade();
  }

  Row _buildUserInfoSection() {
    return Row(
      children: [
        CircleAvatar(
          radius: 38,
          child: Image.asset('assets/images/logo.png'),
        ),
        const SizedBox(width: 20),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username Surname',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'usermail@mail.com',
              style: TextStyle(
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
        CustomGridItem(
          title: 'Ayarlar',
          clickColor: Theme.of(context).colorScheme.primaryContainer,
          backgroundColor: Colors.grey.shade200,
          icon: Icons.settings_outlined,
          iconSize: 50,
          onTap: () {
            print('settings clicked');
          },
        ),
      ],
    );
  }

  CustomGridItem _buildCardsGridItem(BuildContext context) {
    return CustomGridItem(
      title: 'Kartlarım',
      clickColor: Theme.of(context).colorScheme.primaryContainer,
      backgroundColor: Colors.grey.shade200,
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
      backgroundColor: Colors.grey.shade200,
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
      backgroundColor: Colors.grey.shade200,
      icon: Icons.list_alt_rounded,
      iconSize: 50,
      onTap: () {
        print('orders Clicked');
      },
    );
  }
}
