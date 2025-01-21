import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? borderRadius;
  final TextStyle? textStyle;
  final bool isLoading;

  const CommonButton({
    super.key,
    required this.btnText,
    required this.onTap,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 8.0,
    this.textStyle,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading == true ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          side: borderColor != null
              ? BorderSide(color: borderColor!)
              : BorderSide.none,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null) ...[
            Icon(prefixIcon, size: 18),
            const SizedBox(width: 8),
          ],
          Text(
            btnText,
            style: textStyle,
          ),
          if (suffixIcon != null) ...[
            const SizedBox(width: 8),
            Icon(
              suffixIcon,
              size: 18,
            ),
          ],
        ],
      ),
    );
  }
}
