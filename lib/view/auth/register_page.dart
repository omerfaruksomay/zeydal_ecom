import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view_model/auth/register_view_model.dart';

import '../widgets/custom_textfield.dart';
import '../widgets/cutom_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset('assets/images/logo.png', scale: 2),
                _buildEmailTextField(),
                _buildPasswordTextField(),
                Row(
                  children: [
                    Expanded(child: _buildNameTextField()),
                    Expanded(child: _buildSurnameTextField()),
                  ],
                ),
                _buildPhoneNumTextField(),
                Row(
                  children: [
                    Expanded(child: _buildCountryTextField(context)),
                    Expanded(child: _buildCityTextField(context)),
                    Expanded(child: _buildZipCodeTextField()),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildAddressTextField()),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLoginButton(context),
                    SizedBox(width: 30),
                    _buildRegisterButton(context),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            //_buildSocialAccounts(context),
          ],
        ),
      ),
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

  Widget _buildNameTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, bottom: 5, top: 5),
      child: CustomTextField(
        controller: _nameController,
        label: "İsim",
      ),
    );
  }

  Widget _buildSurnameTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20, bottom: 5, top: 5),
      child: CustomTextField(
        controller: _surNameController,
        label: "Soyisim",
      ),
    );
  }

  Widget _buildPhoneNumTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: CustomTextField(
        controller: _phoneController,
        label: "Telefon No",
        keyboardType: TextInputType.phone,
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

  Widget _buildAddressTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
      child: CustomTextField(
        keyboardType: TextInputType.text,
        controller: _addressController,
        label: "Adres",
      ),
    );
  }

  Widget _buildCityTextField(context) {
    RegisterViewModel viewModel = Provider.of(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 0, bottom: 5, top: 5),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Şehir',
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        items: viewModel.cities
            .map<DropdownMenuItem>((String value) => DropdownMenuItem(
                  child: Text(value),
                  value: value,
                ))
            .toList(),
        onChanged: (value) {
          viewModel.cityDropDownOnChange(value);
        },
      ),
    );
  }

  Widget _buildCountryTextField(context) {
    RegisterViewModel viewModel = Provider.of(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 0, bottom: 5, top: 5),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Ülke',
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        items: viewModel.countries
            .map<DropdownMenuItem>((String value) => DropdownMenuItem(
                  child: Text(value),
                  value: value,
                ))
            .toList(),
        onChanged: (value) {
          viewModel.countryDropDownOnChange(value);
        },
      ),
    );
  }

  Widget _buildZipCodeTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20, bottom: 5, top: 5),
      child: CustomTextField(
        keyboardType: TextInputType.number,
        controller: _zipCodeController,
        label: "Posta kodu",
      ),
    );
  }

  Widget _buildRegisterButton(context) {
    RegisterViewModel viewModel = Provider.of(context, listen: false);
    return CustomButton(
      label: "Kayıt Ol",
      labelColor: Colors.white,
      buttonColor: Theme.of(context).colorScheme.primary,
      minWidth: 50,
      minHeight: 50,
      fontSize: 20,
      onPressed: () {
        viewModel.registerUser(
            _emailController.text,
            _passwordController.text,
            _nameController.text,
            _surNameController.text,
            _phoneController.text,
            viewModel.selectedValueCountry.toString(),
            viewModel.selectedValueCity.toString(),
            _zipCodeController.text,
            _addressController.text,
            context);
      },
    );
  }

  Widget _buildLoginButton(context) {
    return CustomButton(
      label: "Giriş Yap",
      labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
      buttonColor: Theme.of(context).colorScheme.primaryContainer,
      minWidth: 50,
      minHeight: 50,
      fontSize: 20,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

/*  Widget _buildSocialAccounts(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          const Text(
            "Ya da Google ile devam edin",
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
            ],
          )
        ],
      ),
    );
  }*/
}
