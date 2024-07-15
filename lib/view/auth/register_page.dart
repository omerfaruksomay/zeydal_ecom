import 'package:flutter/material.dart';

import '../widgets/custom_textfield.dart';
import '../widgets/cutom_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 50),
            Column(
              children: [
                Image.asset('assets/images/logo.png', scale: 10),
                _buildNameTextField(),
                _buildEmailTextField(),
                _buildPasswordTextField(),
                const SizedBox(height: 10),
                _buildRegisterButton(context),
                const SizedBox(height: 10),
                _buildLoginButton(context),
              ],
            ),
            const SizedBox(height: 100),
            _buildSocialAccounts(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: CustomTextField(
        controller: _nameController,
        label: "Name",
      ),
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
        label: "Password",
      ),
    );
  }

  Widget _buildRegisterButton(context) {
    return CustomButton(
      label: "Register",
      labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
      buttonColor: Theme.of(context).colorScheme.primary,
      minWidth: 350,
      minHeight: 50,
      fontSize: 20,
      onPressed: () {
        // Navigator.pushAndRemoveUntil(
        //   context,
        // MaterialPageRoute(
        // builder: (context) => ChangeNotifierProvider(
        // create: (context) => MainLayoutViewModel(),
        //child: const MainLayout(),
        // ),
        //),
        //(route) => false);
      },
    );
  }

  Widget _buildLoginButton(context) {
    return CustomButton(
      label: "Go to Login Page",
      labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
      buttonColor: Theme.of(context).colorScheme.primaryContainer,
      minWidth: 350,
      minHeight: 50,
      fontSize: 20,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildSocialAccounts(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Or Continue With Social Account",
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
