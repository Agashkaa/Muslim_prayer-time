import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const RoundButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FilledButton(
          onPressed: onPressed,
          child: Text(title),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          textStyle: const TextStyle(fontWeight:.bold,fontSize: 16),
        ),
      ),
    );
  }
}
