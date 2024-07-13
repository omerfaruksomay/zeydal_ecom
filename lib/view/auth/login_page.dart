import 'package:flutter/material.dart';
import 'package:zeydal_ecom/view/auth/register_page.dart';
import 'package:zeydal_ecom/view/widgets/custom_textfield.dart';
import 'package:zeydal_ecom/view/widgets/cutom_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildEmailTextField(),
                _buildPasswordTextField(),
                const SizedBox(height: 10),
                _buildLoginButton(context),
                const SizedBox(height: 10),
                _buildRegisterButton(context),
              ],
            ),
            _buildSocialAccounts(context),
          ],
        ),
      ),
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
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: InkWell(
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
            ),
            const SizedBox(width: 15),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: InkWell(
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
            ),
          ],
        )
      ],
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

  Widget _buildLoginButton(context) {
    return CustomButton(
      label: "Login",
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

  Widget _buildRegisterButton(context) {
    return CustomButton(
      label: "Register",
      labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
      buttonColor: Theme.of(context).colorScheme.primaryContainer,
      minWidth: 350,
      minHeight: 50,
      fontSize: 20,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  RegisterPage(),
            ));
      },
    );
  }
}
