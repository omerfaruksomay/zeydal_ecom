import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view_model/main_pages/profile_page/update_password_page_view_model.dart';

import '../../widgets/custom_textfield.dart';
import '../../widgets/cutom_button.dart';

class UpdatePasswordPage extends StatelessWidget {
  UpdatePasswordPage({super.key});

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 75),
            Column(
              children: [
                _buildImage(),
                _buildTextField(_oldPasswordController, "Eski Şifre"),
                _buildTextField(_newPasswordController, "Yeni Şifre"),
                _buildTextField(_confirmPasswordController, "Şifreyi Onayla"),
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
      scale: 2,
    );
  }

  Widget _buildTextField(TextEditingController emailController, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: CustomTextField(
        keyboardType: TextInputType.text,
        isObscure: true,
        controller: emailController,
        label: label,
      ),
    );
  }

  Widget _buildResetPasswordButton(context) {
    UpdatePasswordPageViewModel viewModel = Provider.of(context, listen: false);
    return CustomButton(
        label: "Şifreyi Güncelle",
        labelColor: Colors.white,
        buttonColor: Theme.of(context).colorScheme.primary,
        minWidth: 350,
        minHeight: 50,
        fontSize: 20,
        onPressed: () {
          viewModel.updatePassword(context, _oldPasswordController.text,
              _newPasswordController.text, _confirmPasswordController.text);
        });
  }
}
