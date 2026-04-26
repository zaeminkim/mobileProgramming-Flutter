import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// 네온 텍스트 태그 (#역사, #요리 등)
class NeonTag extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const NeonTag({
    super.key,
    required this.text,
    this.color = AppColors.cyan,
    this.fontSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          shadows: [
            Shadow(
              color: color.withOpacity(0.5),
              blurRadius: 6,
            ),
          ],
        ),
      ),
    );
  }
}
