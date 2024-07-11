import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.label,
    required this.labelColor,
    required this.buttonColor,
    required this.minWidth,
    required this.minHeight,
    this.fontSize,
    this.fontWeight,
  });

  final void Function()? onPressed;
  final String label;
  final Color labelColor;
  final Color buttonColor;
  final double minWidth;
  final double minHeight;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(minWidth, minHeight),
        backgroundColor: buttonColor,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
            color: labelColor, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
