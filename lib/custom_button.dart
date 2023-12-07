import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.icon,
    required this.text,
    this.buttonColor,
    this.padding = 15.0,
    this.onTap,
  });
  final IconData icon;
  final String text;
  final Color? buttonColor;
  final double padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: buttonColor ?? Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Icon(
                icon,
                color: Colors.white,
                size: padding * 2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
