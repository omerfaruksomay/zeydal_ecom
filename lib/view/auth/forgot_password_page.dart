import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view_model/auth/forgot_password_page_view_model.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/cutom_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Column(
              children: [
                _buildImage(),
                _buildEmailTextField(),
                const SizedBox(
                  height: 10,
                ),
                _buildResetPasswordButton(context),
              ],
            ),
            const SizedBox(height: 10),
          ],
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: CustomTextField(
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        label: "Email",
      ),
    );
  }

  Widget _buildResetPasswordButton(context) {
    ForgotPasswordViewModel viewModel = Provider.of(context, listen: false);
    return CustomButton(
        label: "Şifreyi Sıfırla",
        labelColor: Colors.white,
        buttonColor: Theme.of(context).colorScheme.primary,
        minWidth: 350,
        minHeight: 50,
        fontSize: 20,
        onPressed: () {
          viewModel.sendPasswordResetEmail(context, _emailController.text);
        });
  }
}
