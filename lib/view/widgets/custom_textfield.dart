import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isObscure,
    this.keyboardType,
    this.maxLines,
    this.isAlignLabel,
  });

  final TextEditingController controller;
  final String label;
  final bool? isObscure;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool? isAlignLabel;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      obscureText: isObscure ?? false,
      controller: controller,
      decoration: InputDecoration(
        alignLabelWithHint: isAlignLabel ?? false,
        label: Text(
          label,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
