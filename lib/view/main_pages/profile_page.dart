import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Benim Profilim',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            _buildUserInfoSection(),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            _buildMenuItem(context),
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

  Widget _buildMenuItem(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        highlightColor: Colors.white,
        splashColor: Colors.white,
        onTap: () {
          print('Orders button pressed');
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Siparişlerim',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '12 adet siparişiniz bulunmakta',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
