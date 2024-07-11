import 'package:flutter/material.dart';
import 'package:zeydal_ecom/view/auth/register_page.dart';
import 'package:zeydal_ecom/view/main_layout.dart';
import 'package:provider/provider.dart';


import '../../view_model/main_layout_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 30),
            ),
            FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: const Text("register")),
            FilledButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => MainLayoutViewModel(),
                          child: const MainLayout(),
                        ),
                      ),
                      (route) => false);
                },
                child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}
