import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(
        "Shop Page",
        style: TextStyle(fontSize: 30),
      ).animate().fade(),
    );
  }
}
