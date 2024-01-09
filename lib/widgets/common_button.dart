import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  const CommonButton({
    super.key,
    required this.title,
    required this.onPress,
    this.paddingVertical,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });
  final double? paddingVertical;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: backgroundColor ?? Theme.of(context).colorScheme.primary,
          border:
              Border.all(width: 2, color: borderColor ?? Colors.transparent),
        ),
        child: Padding(
          // padding: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(paddingVertical ?? 16),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor ?? Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
