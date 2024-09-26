import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeydal_ecom/view/auth/login_page.dart';
import 'package:zeydal_ecom/view/main_layout.dart';
import 'package:zeydal_ecom/view_model/auth/login_view_model.dart';
import 'package:zeydal_ecom/view_model/main_layout_view_model.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<LoginViewModel>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zeydal',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightGreenAccent,
            background: Colors.white,
          ),
          useMaterial3: true,
        ),
        home: authViewModel.isLoggedIn
            ? ChangeNotifierProvider(
                create: (context) => MainLayoutViewModel(),
                child: const MainLayout(),
              )
            : ChangeNotifierProvider(
                create: (context) => LoginViewModel(),
                child: LoginPage(),
              ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
