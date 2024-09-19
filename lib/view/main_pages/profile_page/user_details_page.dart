import 'package:flutter/material.dart';
import 'package:zeydal_ecom/data/model/user.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({super.key, required this.userData});

  final User userData;

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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.secondaryContainer),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "İletişim Bilgileri",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const Divider(),
                      Text(
                        "Ad Soyad = ${userData.name} ${userData.surname}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Email = ${userData.email}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Telefon Numarası = ${userData.phoneNumber}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.secondaryContainer),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Adres Bilgileri",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const Divider(),
                      Text(
                        "Ad Soyad = ${userData.name} ${userData.surname}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Email = ${userData.email}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Telefon Numarası = ${userData.phoneNumber}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
