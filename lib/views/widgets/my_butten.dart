import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.color,
      required this.onPressed,
      required this.title,
      this.icon,
      this.textColor});

  final Color color;
  final void Function() onPressed;
  final String title;
  final IconData? icon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      textColor: textColor,
      color: color,
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
