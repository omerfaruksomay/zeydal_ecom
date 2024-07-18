import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/auth/login_page.dart';
import 'package:zeydal_ecom/view_model/auth/login_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreenAccent,
          background: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
        child: LoginPage(),
      ),
    );
  }
}
