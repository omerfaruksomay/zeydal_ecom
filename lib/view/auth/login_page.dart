import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/auth/register_page.dart';
import 'package:zeydal_ecom/view/widgets/custom_textfield.dart';
import 'package:zeydal_ecom/view/widgets/cutom_button.dart';

import '../../view_model/main_layout_view_model.dart';
import '../main_layout.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Column(
                children: [
                  _buildImage(),
                  _buildEmailTextField(),
                  _buildPasswordTextField(),
                  const SizedBox(height: 10),
                  _buildLoginButton(context),
                  const SizedBox(height: 10),
                  _buildRegisterButton(context),
                ],
              ),
              const SizedBox(height: 100),
              _buildSocialAccounts(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Image.asset(
      'assets/images/logo.png',
      scale: 10,
    );
  }

  Widget _buildEmailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: CustomTextField(
        controller: _emailController,
        label: "Email",
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: CustomTextField(
        controller: _passwordController,
        label: "Şifre",
      ),
    );
  }

  Widget _buildLoginButton(context) {
    return CustomButton(
      label: "Giriş Yap",
      labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
      buttonColor: Theme.of(context).colorScheme.primary,
      minWidth: 350,
      minHeight: 50,
      fontSize: 20,
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
    );
  }

  Widget _buildRegisterButton(context) {
    return CustomButton(
      label: "Kayıt Ol",
      labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
      buttonColor: Theme.of(context).colorScheme.primaryContainer,
      minWidth: 350,
      minHeight: 50,
      fontSize: 20,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterPage(),
            ));
      },
    );
  }

  Widget _buildSocialAccounts(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Google veya Facebook ile devam edin",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              highlightColor: Theme.of(context).colorScheme.primaryContainer,
              onTap: () {
                print("Google pressed");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/google.png',
                  scale: 2,
                ),
              ),
            ),
            const SizedBox(width: 15),
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              highlightColor: Theme.of(context).colorScheme.primaryContainer,
              onTap: () {
                print("Facebook pressed");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/facebook.png',
                  scale: 2,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
