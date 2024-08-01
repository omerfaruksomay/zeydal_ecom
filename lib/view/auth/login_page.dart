import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/widgets/custom_textfield.dart';
import 'package:zeydal_ecom/view/widgets/cutom_button.dart';
import 'package:zeydal_ecom/view_model/auth/login_view_model.dart';

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
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        label: "Email",
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: CustomTextField(
        isObscure: true,
        controller: _passwordController,
        label: "Şifre",
      ),
    );
  }

  Widget _buildLoginButton(context) {
    LoginViewModel viewModel = Provider.of(context, listen: false);
    return CustomButton(
      label: "Giriş Yap",
      labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
      buttonColor: Theme.of(context).colorScheme.primary,
      minWidth: 350,
      minHeight: 50,
      fontSize: 20,
      onPressed: () => viewModel.login(
          _emailController.text, _passwordController.text, context),
    );
  }

  Widget _buildRegisterButton(context) {
    LoginViewModel viewModel = Provider.of(context, listen: false);
    return CustomButton(
      label: "Kayıt Ol",
      labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
      buttonColor: Theme.of(context).colorScheme.primaryContainer,
      minWidth: 350,
      minHeight: 50,
      fontSize: 20,
      onPressed: () => viewModel.register(context),
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
        InkWell(
          splashColor: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          highlightColor: Theme.of(context).colorScheme.primaryContainer,
          onTap: () {

          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/google.png',
              scale: 2,
            ),
          ),
        )
      ],
    );
  }
}
