import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  const CustomSnackbar(
      {super.key,
      required this.title,
      required this.message,
      required this.contentType});

  final String title;
  final String message;
  final ContentType contentType;

  @override
  Widget build(BuildContext context) {
    return AwesomeSnackbarContent(
      contentType: contentType,
      message: message,
      title: title,
    );
  }
}
