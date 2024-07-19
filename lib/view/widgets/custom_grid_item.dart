import 'package:flutter/material.dart';

class CustomGridItem extends StatelessWidget {
  const CustomGridItem({
    super.key,
    required this.title,
    required this.clickColor,
    this.onTap,
    this.icon,
    this.iconSize,
  });

  final void Function()? onTap;

  final String title;
  final IconData? icon;
  final Color clickColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        splashColor: clickColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        highlightColor: clickColor,
        onTap: onTap,
        child: GridTile(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: iconSize,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
